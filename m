Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D733EECDFB0
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 06:58:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 724D7208C4
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 06:58:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="0H7ju8i/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 724D7208C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729660AbeGMHLZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 03:11:25 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:40952 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727569AbeGMHLZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 03:11:25 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w6D6o49i191018;
        Fri, 13 Jul 2018 06:57:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=mime-version :
 message-id : date : from : to : cc : subject : references : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=kTcueVnqZTsU3LhEc+5V6sY6+wHDA8HKaReRVWjb2zE=;
 b=0H7ju8i/nonrvndOVFXRY0yxFmbHEBlekTnpeufDHa/ijjKH0DmlR9tshQqKsMbqsH84
 iChzZgc1yWtBX/x8yAVvrC2uBvMkgQJV62UU4AotSDyY7wrj1st7u6Cj548THhSW7LTj
 lg0/hCmePsxla8tJR375oslHgrIJzpHozTd/XcwIicPiY61UxKTJd/R5m5dBB67P7NZI
 zeYihe8bPipf73CItpZgiYvkL3xbaxuPMBHRTyjXbIo6i/WmuFaVyS9abzo/rzFewKQu
 Xs74BBz3fw5VwaYLYKplmbHFpqW28WD5lnKBLF6bgG8oT9z83ewr95lnBrIjtt4zGiPx MA== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by aserp2120.oracle.com with ESMTP id 2k2p7e6g68-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 13 Jul 2018 06:57:47 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w6D6vlZj004525
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 13 Jul 2018 06:57:47 GMT
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w6D6vhha012325;
        Fri, 13 Jul 2018 06:57:43 GMT
Received: from mwanda (/41.202.241.32) by default (Oracle Beehive Gateway
 v4.0) with ESMTP ; Fri, 13 Jul 2018 06:57:32 +0000
USER-AGENT: NeoMutt/20170609 (1.8.3)
MIME-Version: 1.0
Message-ID: <20180713065721.a5cntccedumupewo@mwanda>
Date:   Thu, 12 Jul 2018 23:57:22 -0700 (PDT)
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Tuomas Tynkkynen <tuomas@tuxera.com>
Cc:     Stefan Wahren <stefan.wahren@i2se.com>, devel@driverdev.osuosl.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, Eric Anholt <eric@anholt.net>,
        linux-rpi-kernel@lists.infradead.org
Subject: Re: [PATCH 1/2] staging: bcm2835-audio: Check if workqueue allocation
 failed
References: <20180712215417.22491-1-tuomas@tuxera.com>
 <20180713064816.lv6qhkipi6fpeptj@mwanda>
In-Reply-To: <20180713064816.lv6qhkipi6fpeptj@mwanda>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8952 signatures=668706
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=913
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1806210000 definitions=main-1807130042
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 13, 2018 at 09:48:16AM +0300, Dan Carpenter wrote:
> On Fri, Jul 13, 2018 at 12:54:16AM +0300, Tuomas Tynkkynen wrote:
> > @@ -424,7 +411,9 @@ int bcm2835_audio_open(struct bcm2835_alsa_stream *alsa_stream)
> >  	int status;
> >  	int ret;
> >  
> > -	my_workqueue_init(alsa_stream);
> > +	alsa_stream->my_wq = alloc_workqueue("my_queue", WQ_HIGHPRI, 1);
> > +	if (!alsa_stream->my_wq)
> > +		return -ENOMEM;
> >  
> >  	ret = bcm2835_audio_open_connection(alsa_stream);
> >  	if (ret) {
> 
> This patch is good but if bcm2835_audio_open_connection() fails then
> we need to release alsa_stream->my_wq.

Never mind, you handle it in the next patch.  The bug *was* there in the
original code as well, so that's a legit way to split the patches.

regards,
dan carpenter
