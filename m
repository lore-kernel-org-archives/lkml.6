Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9522FC04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 10:20:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D64382082D
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 10:20:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=oberhumer.com header.i=@oberhumer.com header.b="CbyVzUek"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D64382082D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=oberhumer.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726160AbeLDKUk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 05:20:40 -0500
Received: from mail.servus.at ([193.170.194.20]:52714 "EHLO mail.servus.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725613AbeLDKUj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 05:20:39 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail.servus.at (Postfix) with ESMTP id 999113000694;
        Tue,  4 Dec 2018 11:20:36 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=oberhumer.com; h=
        content-transfer-encoding:content-type:content-type:in-reply-to
        :mime-version:user-agent:date:date:message-id:organization:from
        :from:references:subject:subject:received:received; s=main; t=
        1543918834; x=1545733235; bh=Fw+hj3pVPsQRnpZvAJxFKSQglr7+hWbZ66N
        C0wszn10=; b=CbyVzUekV5PpQY59xIF1ZrbTDeD+n/eoR4KEOu4XIyfnf3S181Y
        EojE6rbpK5u3Fh18QItX70tYy/oH8NoO4+0T3s4I8hgWwbi27eIrgtc2hVCaWP5L
        ww8rxQ5SdcN1sUPi9U/DVdz6uc5bPpnOhd76n1fxMUwPQY9sHpJ0IpmE=
X-Virus-Scanned: amavisd-new at servus.at
Received: from mail.servus.at ([127.0.0.1])
        by localhost (mail.servus.at [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id K6AhSrVQqxfE; Tue,  4 Dec 2018 11:20:34 +0100 (CET)
Received: from [192.168.216.53] (unknown [81.10.228.128])
        (Authenticated sender: oh_markus)
        by mail.servus.at (Postfix) with ESMTPSA id 1941D300069A;
        Tue,  4 Dec 2018 11:20:31 +0100 (CET)
Subject: Re: [PATCH v2] lzo: fix ip overrun during compress.
To:     dsterba@suse.cz, Yueyi Li <liyueyi@live.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "w@1wt.eu" <w@1wt.eu>,
        "donb@securitymouse.com" <donb@securitymouse.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <BLUPR13MB0289EFEB79833470EE62F48EDFD10@BLUPR13MB0289.namprd13.prod.outlook.com>
 <20181128135242.gy3avmbp2pdmjaka@twin.jikos.cz>
From:   "Markus F.X.J. Oberhumer" <markus@oberhumer.com>
Organization: oberhumer.com
Message-ID: <5C0654EE.5040001@oberhumer.com>
Date:   Tue, 4 Dec 2018 11:20:30 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.3.0
MIME-Version: 1.0
In-Reply-To: <20181128135242.gy3avmbp2pdmjaka@twin.jikos.cz>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I don't think that address space wraparound is legal in C, but I
understand that we are in kernel land and if you really want to
compress the last virtual page 0xfffffffffffff000 the following
small patch should fix that dubious case.

This also avoids slowing down the the hot path of the compression
core function.

Cheers,
Markus



diff --git a/lib/lzo/lzo1x_compress.c b/lib/lzo/lzo1x_compress.c
index 236eb21167b5..959dec45f6fe 100644
--- a/lib/lzo/lzo1x_compress.c
+++ b/lib/lzo/lzo1x_compress.c
@@ -224,8 +224,8 @@ int lzo1x_1_compress(const unsigned char *in, size_t in_len,
 
        while (l > 20) {
                size_t ll = l <= (M4_MAX_OFFSET + 1) ? l : (M4_MAX_OFFSET + 1);
-               uintptr_t ll_end = (uintptr_t) ip + ll;
-               if ((ll_end + ((t + ll) >> 5)) <= ll_end)
+               // check for address space wraparound
+               if (((uintptr_t) ip + ll + ((t + ll) >> 5)) <= (uintptr_t) ip)
                        break;
                BUILD_BUG_ON(D_SIZE * sizeof(lzo_dict_t) > LZO1X_1_MEM_COMPRESS);
                memset(wrkmem, 0, D_SIZE * sizeof(lzo_dict_t));



On 2018-11-28 14:52, David Sterba wrote:
> Adding Markus to to CC
> 
> On Wed, Nov 28, 2018 at 07:31:26AM +0000, Yueyi Li wrote:
>> It`s possible ip overrun in lzo1x_1_do_compress() when compressed page is
>> point to the end of memory and which virtual address is 0xfffffffffffff000.
>> Leading to a NULL pointer access during the get_unaligned_le32(ip).
> 
> So this could happen in practice in zram, but unlikely for other users
> of lzo (like btrfs). I'm not sure but expect that the last page would
> not be returned by allocator.
> 
> The fix is adding a few branches to code that's supposed to be as fast
> as possible. The branches would be evaluated all the time while
> protecting against one signle bad page address. This does not look like
> a good performance tradeoff.
> 
>> +#define OVERFLOW_ADD_CHECK(a, b)  \
>> +		(((a) + (b)) < (a))
> 
> I'm not sure if this is generally safe overflow check (never not
> optimized out). Here it depends on the types of 'a' and 'b' that are
> pointer (ip) and size_t (m_len). GCC has __builtin_add_overflow_p so
> that one should be used where possible.
> 

-- 
Markus Oberhumer, <markus@oberhumer.com>, http://www.oberhumer.com/
