Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 979C0C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 09:10:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4395C208AE
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 09:10:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="lBOSD8Jw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4395C208AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754330AbeFLJKc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 05:10:32 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:48414 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754182AbeFLJKb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 05:10:31 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w5C96Ffd111095;
        Tue, 12 Jun 2018 09:10:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 content-transfer-encoding : in-reply-to; s=corp-2017-10-26;
 bh=FiiuYY6YhyLK6gF8sr29BeG/PNRYKdq6Lkg5g0DquaU=;
 b=lBOSD8JwrEl6BOjyDUnghhLsqUpO7eRsZXx0XANef3LOEiaL04VqZIaFHSKrvoyqHgiM
 uuWndg50c5dqIpDOojjxidz6L9Jhy9v/iLfnnetmjx9Fqc0TfxPdfD92Lt3HDbOr4wZO
 RuwbfIxghHY1MCxAWnsw6SKB7SZOSkABwFWs2TDpoZZZ+hoiuGuFtR3H9NnQc6Xv43T4
 blU2F/M6BXxlDl7aOe5/BgBl27Y8N7WXyK34sJGa7s8odW5Qn88vKJSFr67pm7+EEpoZ
 2bidjjhgs6xteq97e4Qt0fVBneEU0GYDUhyJe88Y+fJ7R+p3wjhj0ILvJkLE2bw2iB/m +g== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by userp2120.oracle.com with ESMTP id 2jg7hx13dn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Jun 2018 09:10:25 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w5C9AP63002850
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Jun 2018 09:10:25 GMT
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w5C9AO0X013706;
        Tue, 12 Jun 2018 09:10:24 GMT
Received: from mwanda (/197.157.0.30)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 12 Jun 2018 02:10:24 -0700
Date:   Tue, 12 Jun 2018 12:10:16 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Colin King <colin.king@canonical.com>
Cc:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][V2] drm/i915/guc: fix GEM_BUG_ON check
Message-ID: <20180612091016.yi4lbmdgcltmcen3@mwanda>
References: <20180611164653.13691-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180611164653.13691-1-colin.king@canonical.com>
User-Agent: NeoMutt/20170609 (1.8.3)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8921 signatures=668702
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=950
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1805220000 definitions=main-1806120109
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 11, 2018 at 05:46:53PM +0100, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> The check for level being less than zero always false because flags
> is currently unsigned and can never be negative. Fix this by making
> flags a s32.
> 
> Detected by CoverityScan, CID#1468363 ("Macro compares unsigned to 0")
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> 
> ---
> V2: Make flags s32 rather than remove the GEM_BUG_ON check, thanks to
> Ville Syrjälä for spotting the mistake in my first attempt.
> ---
>  drivers/gpu/drm/i915/intel_guc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/i915/intel_guc.c b/drivers/gpu/drm/i915/intel_guc.c
> index 116f4ccf1bbd..fb31f5004bcf 100644
> --- a/drivers/gpu/drm/i915/intel_guc.c
> +++ b/drivers/gpu/drm/i915/intel_guc.c
> @@ -206,7 +206,7 @@ void intel_guc_fini(struct intel_guc *guc)
>  static u32 get_log_control_flags(void)
>  {
>  	u32 level = i915_modparams.guc_log_level;
> -	u32 flags = 0;
> +	s32 flags = 0;
>  
>  	GEM_BUG_ON(level < 0);

Only insane people use "s32" when it's not part of the hardware spec and
you changed the wrong variable...

regards,
dan carpenter

