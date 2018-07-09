Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD88FC5CFE7
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 15:47:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 783C52087F
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 15:47:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 783C52087F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codewreck.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933331AbeGIPrj (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 11:47:39 -0400
Received: from nautica.notk.org ([91.121.71.147]:49418 "EHLO nautica.notk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932688AbeGIPri (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 11:47:38 -0400
Received: by nautica.notk.org (Postfix, from userid 1001)
        id E00D1C009; Mon,  9 Jul 2018 17:47:36 +0200 (CEST)
Date:   Mon, 9 Jul 2018 17:47:21 +0200
From:   Dominique Martinet <asmadeus@codewreck.org>
To:     Tomas Bortoli <tomasbortoli@gmail.com>
Cc:     ericvh@gmail.com, rminnich@sandia.gov, lucho@ionkov.net,
        v9fs-developer@lists.sourceforge.net, syzkaller@googlegroups.com,
        davem@davemloft.net, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org
Subject: Re: [V9fs-developer] [PATCH] KASAN: slab-out-of-bounds Read in
 pdu_read
Message-ID: <20180709154721.GA19552@nautica>
References: <534ee9c1-5a43-bda5-a54b-c8c6aa3aecc5@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <534ee9c1-5a43-bda5-a54b-c8c6aa3aecc5@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tomas Bortoli wrote on Mon, Jul 09, 2018:
> I've analyzed this issue found by Syzkaller and I've made a patch:

Please use git send-email to send the patch, this is not applicable as
is (partly because of the foreword you added (you can add arbitrary text
or comment after the first --- in the patch itself or in a cover
letter), but also because your mail client wrapped long lines so the
patch itself is corrupted

> The pdu_read() function suffers from an integer underflow. When
> pdu->offset is greater than pdu->size, the length calculation will have
> a wrong result, resulting in an out-of-bound read.
> 
> Modify the pdu_write() function in the same way (as pdu_read()) although
> the modification is NOT necessary to fix crashes induced by the
> reproducer at issue I think it makes sense to have symmetry between the
> two functions (and a check more does not harm).
> 
> The p9_client_version() does not initialize the version pointer. If the
> call to p9pdu_readf() returns an error and version has not been
> allocated in p9pdu_readf(), then the program will jump to the "error"
> label and will try to free the version pointer. If version is not
> initialized, free() might be called with uninitialized, garbage data and
> provoke a crash.

I'd suggest splitting the p9_client_version() change in a second patch
as well, even if it's probably fine for this little.

> Modify the p9_check_errors() function to check for PDUs with "size >
> capacity" to prevent out-of-bound reads.

Ditto as it's unrelated as well.

>  size_t pdu_read(struct p9_fcall *pdu, void *data, size_t size)
>  {
> -    size_t len = min(pdu->size - pdu->offset, size);
> -    memcpy(data, &pdu->sdata[pdu->offset], len);
> +    size_t len = pdu->offset > pdu->size ? 0 : min(pdu->size -
> pdu->offset, size);

This line (once unwrapped) is over 80 characters, try to run
checkpatch.pl against your patch

> +    if(len != 0)
> +        memcpy(data, &pdu->sdata[pdu->offset], len);
>      pdu->offset += len;
>      return size - len;
>  }
>  
>  static size_t pdu_write(struct p9_fcall *pdu, const void *data, size_t
> size)
>  {
> -    size_t len = min(pdu->capacity - pdu->size, size);
> -    memcpy(&pdu->sdata[pdu->size], data, len);
> +    size_t len = pdu->size > pdu->capacity ? 0 : min(pdu->capacity -
> pdu->size, size);
> +    if(len != 0)
> +        memcpy(&pdu->sdata[pdu->size], data, len);
>      pdu->size += len;
>      return size - len;
>  }
> --- b/net/9p/client.c    2018-07-09 16:46:25.459541292 +0200
> +++ a/net/9p/client.c    2018-07-09 16:15:36.337500567 +0200
> @@ -519,10 +519,13 @@ EXPORT_SYMBOL(p9_parse_header);
>  static int p9_check_errors(struct p9_client *c, struct p9_req_t *req)
>  {
>      int8_t type;
> +    int32_t size;
>      int err;
>      int ecode;
>  
>      err = p9_parse_header(req->rc, &size, &type, NULL, 0);

Your patch adds the 'size' variable a few lines above but this line
didn't change? Something is wrong here; you changed a NULL to &size so
git should pick it up.

> +    if(size > req->rc->capacity)
> +        return -EINVAL;

Hmm, tricky - this isn't enough, we could read uninitialized data if
size is bigger than what was read but still < capacity.
For trans_fd, rc->offset seems to hold the size actually read but other
transports do not do this properly.
This might work as a band-aid but it needs a bigger patch that properly
stores in the fcall how much was read and then checks that.

trans_rdma does not store the actual read size at all (it is in the
'wc->byte_len' in 'recv_done()'), it doesn't look like virtio does it
either but I am not familiar with that part of the code.

> Looking forward your feedback,

Thanks for taking the time to look at the syzbot reports and send a
patch, do not hesitate to ask questions if I wasn't clear or if you need
help with the bigger change I suggested.

-- 
Dominique Martinet | Asmadeus
