Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3E6FC04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 07:00:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EC202087F
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 07:00:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="dboaIDQp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7EC202087F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726075AbeLDHAx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 02:00:53 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:59790 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725983AbeLDHAw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 02:00:52 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id wB470jsn190362;
        Tue, 4 Dec 2018 07:00:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=jQ4s3cEvEX0vkaUscyEl129CpxWqK9ErF2zF0DJSxRM=;
 b=dboaIDQpRgvuponOs9xS2w/HDzApxhKGJ+dj5LF99Bp/8e/COCcaDbswfgFPFtPW2po3
 Nabv73zxCAWUbbdl25lqYyl6M8gb2H6lKkNpLY5h0M9N170n5JYKkrXsDqP2Uy2J1DOg
 NmSx8cCJcw8BJFYW45aJlNRbOZWu+iuLSiRaRgt1vql4Ypt8eXc6gA+qzIoQNMON2a6c
 MXBySR7FjgnS+jutt3aAqQFTbNAPRab2u+23vSIznJqC9zHDqW3p0hjcimAB0QdcNkPZ
 D8RG1WAs9mk0eJBOZQN9FlW3mzP6Gf98eeYGei+bnUOqzsyhXmnN4JffG9WuXLNcTZVO 0A== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by userp2130.oracle.com with ESMTP id 2p3hqttjtm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 04 Dec 2018 07:00:45 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id wB470i8P018614
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 4 Dec 2018 07:00:44 GMT
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id wB470hNh020313;
        Tue, 4 Dec 2018 07:00:43 GMT
Received: from unbuntlaptop (/197.157.0.25)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 03 Dec 2018 23:00:43 -0800
Date:   Tue, 4 Dec 2018 10:00:33 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Richard Cochran <richardcochran@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org, YueHaibing <yuehaibing@huawei.com>
Subject: Re: [PATCH v2] ptp: fix an IS_ERR() vs NULL check
Message-ID: <20181204070033.GG3073@unbuntlaptop>
References: <20181130163252.e6z33t23j3qud57z@localhost>
 <20181203105506.GA21127@unbuntlaptop>
 <20181204044257.grk3na2wyrx6nssg@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181204044257.grk3na2wyrx6nssg@localhost>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9096 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1812040063
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

I meant to CC you but I screwed up and added you to the From header
instead... :(

Why did you commit 3b1ad360acad ("pps: using ERR_PTR instead of NULL
while pps_register_source fails")?  You're not listed as a maintainer so
I wouldn't have known to CC you.

The back story is that the last chunk which changes drivers/ptp/ptp_clock.c
was dropped by mistake and it's not there in linux-next.  I wrote a
patch which adds it, but everyone is super confused now...  Here is
YueHaibing's original patch btw, for reference.
https://www.spinics.net/lists/netdev/msg535929.html

regards,
dan carpenter


On Mon, Dec 03, 2018 at 08:42:57PM -0800, Richard Cochran wrote:
> On Mon, Dec 03, 2018 at 01:55:06PM +0300, Dan Carpenter wrote:
> > We recently modified pps_register_source() to return error pointers
> > instead of NULL but this check wasn't updated.
> 
> But it *was* updated!
>  
> > Fixes: 3b1ad360acad ("pps: using ERR_PTR instead of NULL while pps_register_source fails")
> > Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> > ---
> > v2:  Use the correct Fixes tag.  Add Greg to the CC list, because he
> > is maintaining this driver.
> 
> What driver?  (I am maintaining drivers/ptp/ptp_clock.c)
>  
> >  drivers/ptp/ptp_clock.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/ptp/ptp_clock.c b/drivers/ptp/ptp_clock.c
> > index 8a81eecc0ecd..48f3594a7458 100644
> > --- a/drivers/ptp/ptp_clock.c
> > +++ b/drivers/ptp/ptp_clock.c
> > @@ -265,8 +265,8 @@ struct ptp_clock *ptp_clock_register(struct ptp_clock_info *info,
> >  		pps.mode = PTP_PPS_MODE;
> >  		pps.owner = info->owner;
> >  		ptp->pps_source = pps_register_source(&pps, PTP_PPS_DEFAULTS);
> > -		if (!ptp->pps_source) {
> > -			err = -EINVAL;
> > +		if (IS_ERR(ptp->pps_source)) {
> > +			err = PTR_ERR(ptp->pps_source);
> >  			pr_err("failed to register pps source\n");
> >  			goto no_pps;
> >  		}
> 
> YueHaibing's patch has the following hunk.  It really is already
> there.  I don't see it yet on Linus' master branch, but the patch
> should update drivers/pps/kapi.c and the callers all in one commit.
> 
> diff --git a/drivers/ptp/ptp_clock.c b/drivers/ptp/ptp_clock.c
> index 8a81eec..48f3594 100644
> --- a/drivers/ptp/ptp_clock.c
> +++ b/drivers/ptp/ptp_clock.c
> @@ -265,8 +265,8 @@ struct ptp_clock *ptp_clock_register(struct ptp_clock_info *info,
>  		pps.mode = PTP_PPS_MODE;
>  		pps.owner = info->owner;
>  		ptp->pps_source = pps_register_source(&pps, PTP_PPS_DEFAULTS);
> -		if (!ptp->pps_source) {
> -			err = -EINVAL;
> +		if (IS_ERR(ptp->pps_source)) {
> +			err = PTR_ERR(ptp->pps_source);
>  			pr_err("failed to register pps source\n");
>  			goto no_pps;
>  		}
> 
> Thanks,
> Richard
