Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFBD2C00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 04:08:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AECBF2084D
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 04:08:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AECBF2084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727530AbeJELFc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 07:05:32 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:56988 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726826AbeJELFc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 07:05:32 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w9544YPI038293
        for <linux-kernel@vger.kernel.org>; Fri, 5 Oct 2018 00:08:41 -0400
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2mwvqu87vx-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 05 Oct 2018 00:08:41 -0400
Received: from localhost
        by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Fri, 5 Oct 2018 00:08:41 -0400
Received: from b01cxnp22036.gho.pok.ibm.com (9.57.198.26)
        by e14.ny.us.ibm.com (146.89.104.201) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 5 Oct 2018 00:08:37 -0400
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w9548aEJ33161288
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 5 Oct 2018 04:08:36 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A0CC7B2064;
        Fri,  5 Oct 2018 00:06:45 -0400 (EDT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 80ADAB205F;
        Fri,  5 Oct 2018 00:06:45 -0400 (EDT)
Received: from paulmck-ThinkPad-W541 (unknown [9.80.210.4])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Fri,  5 Oct 2018 00:06:45 -0400 (EDT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 5027816C1CED; Thu,  4 Oct 2018 21:08:36 -0700 (PDT)
Date:   Thu, 4 Oct 2018 21:08:36 -0700
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     linux-input@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Input: evdev - add a schedule point in evdev_write()
Reply-To: paulmck@linux.ibm.com
References: <20181005005359.GA218372@dtor-ws>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181005005359.GA218372@dtor-ws>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18100504-0052-0000-0000-0000033CC3A1
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009824; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000267; SDB=6.01098052; UDB=6.00567916; IPR=6.00878093;
 MB=3.00023621; MTD=3.00000008; XFM=3.00000015; UTC=2018-10-05 04:08:39
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18100504-0053-0000-0000-00005E4CE141
Message-Id: <20181005040836.GU2674@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-10-05_01:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1810050041
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 04, 2018 at 05:53:59PM -0700, Dmitry Torokhov wrote:
> Large writes to evdev interface may cause rcu stalls. Let's add
> cond_resched() to the loop to avoid this.
> 
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Reviewed-by: Paul E. McKenney <paulmck@linux.ibm.com>

> ---
>  drivers/input/evdev.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/input/evdev.c b/drivers/input/evdev.c
> index 370206f987f9..f48369d6f3a0 100644
> --- a/drivers/input/evdev.c
> +++ b/drivers/input/evdev.c
> @@ -564,6 +564,7 @@ static ssize_t evdev_write(struct file *file, const char __user *buffer,
>  
>  		input_inject_event(&evdev->handle,
>  				   event.type, event.code, event.value);
> +		cond_resched();
>  	}
>  
>   out:
> -- 
> 2.19.0.605.g01d371f741-goog
> 
> 
> -- 
> Dmitry
> 

