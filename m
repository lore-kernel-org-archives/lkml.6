Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A530C282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 15:18:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39509217D4
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 15:18:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="1UXXkLpU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729129AbfAVPSK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 10:18:10 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:42630 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729101AbfAVPSJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 10:18:09 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id x0MFAvGh003633;
        Tue, 22 Jan 2019 15:18:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=KDuShLuFGHIPPr7UEMQ9tH1UlcIP0l5Dd7vW+tAobA4=;
 b=1UXXkLpUxmeSeX665tKg6Zw4DOyfMA9tuvpgZL6XWJTsfurpim56R/7Ve8ZNr/cIWQrP
 6RE7fMWOD6HoliHB/zSOK9XpyTBAhCRkML3MBlhV/3DrjsrHl+GN3QN19CHh7xcL2rZI
 UH5WB297xBzj45fjGjmMT9vWuWUocOjOp4eBSUStR0+5uJYphfGIyz7XEtyDdHs8owhd
 +XHTXi8W33Tl9CXeLt73zFN7QSqdtuVbU8XerDw9zfaE3TwAHYM4kfP2QOnsuMyR2FjQ
 b8413hOaJbbweqnxiZiKD5JNC+6upPXwCk59Q7tcEOrUqFADuwDHxK6fqGDPVD+DZLmg 8A== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by userp2130.oracle.com with ESMTP id 2q3uaum78n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 22 Jan 2019 15:18:03 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id x0MFI2ix029337
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 22 Jan 2019 15:18:03 GMT
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x0MFI2ZI021702;
        Tue, 22 Jan 2019 15:18:02 GMT
Received: from ca-dmjordan1.us.oracle.com (/10.211.9.48)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 22 Jan 2019 07:18:01 -0800
Date:   Tue, 22 Jan 2019 10:18:20 -0500
From:   Daniel Jordan <daniel.m.jordan@oracle.com>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Daniel Jordan <daniel.m.jordan@oracle.com>,
        Tejun Heo <tj@kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] workqueue: Try to catch flush_work() without INIT_WORK().
Message-ID: <20190122151819.qjzihyyd4h2ukou2@ca-dmjordan1.us.oracle.com>
References: <1547831098-7930-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
 <20190118194853.pgdkz2ugwrob3zun@ca-dmjordan1.us.oracle.com>
 <90c831b3-0d09-3cf7-5a2c-2fa7afaa003e@i-love.sakura.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <90c831b3-0d09-3cf7-5a2c-2fa7afaa003e@i-love.sakura.ne.jp>
User-Agent: NeoMutt/20180323-268-5a959c
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9144 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1901220118
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 19, 2019 at 11:41:22AM +0900, Tetsuo Handa wrote:
> On 2019/01/19 4:48, Daniel Jordan wrote:
> > On Sat, Jan 19, 2019 at 02:04:58AM +0900, Tetsuo Handa wrote:
> > __queue_work has a sanity check already for work, but using list_empty.  Seems
> > slightly better to be consistent?
> > 
> 
> list_empty() won't work, for "struct work_struct" is embedded into a struct
> which is allocated by kzalloc().

Please check list_empty's definition again, it compares the address of the node
to its next pointer, so it should work for a zeroed node.  I'll reiterate that
it seems slightly better to be consistent in "is work_struct initialized?"
checks, but it's not a big deal and I'm fine either way.

> From 1bbf8d9c7aaef78d7f483d2131261162485c6f72 Mon Sep 17 00:00:00 2001
> From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> Date: Sat, 19 Jan 2019 01:38:53 +0900
> Subject: [PATCH] drm/vkms: Fix flush_work() without INIT_WORK().
> 
> syzbot is hitting a lockdep warning [1] because flush_work() is called
> without INIT_WORK() after kzalloc() at vkms_atomic_crtc_reset().
> 
> Commit 6c234fe37c57627a ("drm/vkms: Implement CRC debugfs API") added
> INIT_WORK() to only vkms_atomic_crtc_duplicate_state() side. Assuming
> that lifecycle of crc_work is appropriately managed, fix this problem
> by adding INIT_WORK() to vkms_atomic_crtc_reset() side.
> 
> [1] https://syzkaller.appspot.com/bug?id=a5954455fcfa51c29ca2ab55b203076337e1c770
> 
> Reported-and-tested-by: syzbot <syzbot+12f1b031b6da017e34f8@syzkaller.appspotmail.com>
> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> ---
>  drivers/gpu/drm/vkms/vkms_crtc.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/gpu/drm/vkms/vkms_crtc.c b/drivers/gpu/drm/vkms/vkms_crtc.c
> index 177bbcb..3c37d8c 100644
> --- a/drivers/gpu/drm/vkms/vkms_crtc.c
> +++ b/drivers/gpu/drm/vkms/vkms_crtc.c
> @@ -104,6 +104,7 @@ static void vkms_atomic_crtc_reset(struct drm_crtc *crtc)
>  	vkms_state = kzalloc(sizeof(*vkms_state), GFP_KERNEL);
>  	if (!vkms_state)
>  		return;
> +	INIT_WORK(&vkms_state->crc_work, vkms_crc_work_handle);
>  
>  	crtc->state = &vkms_state->base;
>  	crtc->state->crtc = crtc;

Great, thanks, I think mentioning this path would improve the changelog.
