Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBC4EC46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 07:09:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CD382082D
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 07:09:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="5OfXLFEB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7CD382082D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727036AbeJYPka (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 11:40:30 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:44144 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726465AbeJYPka (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 11:40:30 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w9P78SJ7003185;
        Thu, 25 Oct 2018 07:08:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=aKFpQHVKhNDvH4pDlwIR6NhTMOCH1tV527/7thIM3oA=;
 b=5OfXLFEBsRkWdYlmRXVgIzQUldXKvh9c5b7QKFx/sJL4jjHpF1wF3hgkJikdou+2oePV
 Vg/uf9W3lSe6tyAXASAhUSRbtVcLg3cKWqBvX88UHKy3p7LFb7aGO/Ncy9ti19hM1JbQ
 buyZ9/mLbT19dTgPgurtpfQWiJkwbw9DgpE5WlRy1UVajED5WDutmaiHV5B41SH1sTTp
 nRobuzLHpvmBDO8SXPv44IIrJ2WpCqaOJinLEuIAoLABGnNMj80qZTQ1aTEUfmmobZzy
 QFjINZBQjYraCc3dm2SDvG3QG4xCb/GWMxI4EgkmO/SzIQy7EjNATfrRJGlFUUaQgSTP Yg== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by aserp2120.oracle.com with ESMTP id 2n7vaq7p53-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 25 Oct 2018 07:08:28 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w9P78RGa023279
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 25 Oct 2018 07:08:27 GMT
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w9P78PfQ021542;
        Thu, 25 Oct 2018 07:08:25 GMT
Received: from mwanda (/129.205.6.86)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 25 Oct 2018 00:08:25 -0700
Date:   Thu, 25 Oct 2018 10:08:16 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Juergen Gross <jgross@suse.com>
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] x86/ioremap: tighten integer overflow checking
Message-ID: <20181025070816.3e77nr25mskrkzqg@mwanda>
References: <20181025061633.t32bxslxj3h7jv2x@kili.mountain>
 <eaaddd4a-5ed0-9b58-f4be-994ec38ed660@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eaaddd4a-5ed0-9b58-f4be-994ec38ed660@suse.com>
User-Agent: NeoMutt/20170609 (1.8.3)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9056 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1810250067
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, Oct 25, 2018 at 08:28:44AM +0200, Juergen Gross wrote:
> On 25/10/2018 08:16, Dan Carpenter wrote:
> > The current check is a bit off in the case where "phys_addr + size"
> > wraps to zero because then "last_addr" is set to ULONG_MAX which is >=
> > phys_addr.
> 
> And -2 would be okay?
> 

If you see any patches from me it's static checker stuff...

I guess the original is actually fine because the -1 re-wraps back to
what we wanted it to be.  We also do verify that size is correct in
__ioremap_check_mem() so I can't see a problem here after all.

regards,
dan carpenter

