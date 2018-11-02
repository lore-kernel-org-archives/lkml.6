Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCC6EC65C22
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 18:13:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BF032081F
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 18:13:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9BF032081F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728315AbeKCDVl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 23:21:41 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:33782 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728265AbeKCDVk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 23:21:40 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wA2I3fD7009260
        for <linux-kernel@vger.kernel.org>; Fri, 2 Nov 2018 14:13:35 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2ngtm1tcr6-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 02 Nov 2018 14:13:34 -0400
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <zohar@linux.ibm.com>;
        Fri, 2 Nov 2018 18:13:32 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 2 Nov 2018 18:13:29 -0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id wA2IDStZ60424436
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 2 Nov 2018 18:13:28 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 156FEAE056;
        Fri,  2 Nov 2018 18:13:28 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 80CD3AE045;
        Fri,  2 Nov 2018 18:13:26 +0000 (GMT)
Received: from dhcp-9-31-102-82.watson.ibm.com (unknown [9.31.102.82])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri,  2 Nov 2018 18:13:26 +0000 (GMT)
Subject: Re: [PATCH security-next v5 12/30] LSM: Provide separate ordered
 initialization
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Kees Cook <keescook@chromium.org>, James Morris <jmorris@namei.org>
Cc:     Casey Schaufler <casey@schaufler-ca.com>,
        John Johansen <john.johansen@canonical.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Paul Moore <paul@paul-moore.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Jordan Glover <Golden_Miller83@protonmail.ch>,
        LSM <linux-security-module@vger.kernel.org>,
        linux-doc@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Fri, 02 Nov 2018 14:13:26 -0400
In-Reply-To: <20181011001846.30964-13-keescook@chromium.org>
References: <20181011001846.30964-1-keescook@chromium.org>
         <20181011001846.30964-13-keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 18110218-0020-0000-0000-000002DEDA1D
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18110218-0021-0000-0000-0000212E3EEA
Message-Id: <1541182406.20901.31.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-11-02_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=3 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1811020160
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kees,

On Wed, 2018-10-10 at 17:18 -0700, Kees Cook wrote:
> This provides a place for ordered LSMs to be initialized, separate from
> the "major" LSMs. This is mainly a copy/paste from major_lsm_init() to
> ordered_lsm_init(), but it will change drastically in later patches.
> 
> What is not obvious in the patch is that this change moves the integrity
> LSM from major_lsm_init() into ordered_lsm_init(), since it is not marked
> with the LSM_FLAG_LEGACY_MAJOR. As it is the only LSM in the "ordered"
> list, there is no reordering yet created.

I'm so sorry for not reviewing these patches earlier.  Both IMA and
EVM are dependent on "integrity", but "integrity", at least by itself,
should not be considered an LSM.

I don't recall why "integrity" is on the security_initcall, while both
IMA and EVM are on the late_initcall().

Mimi

> 
> Signed-off-by: Kees Cook <keescook@chromium.org>
> Reviewed-by: Casey Schaufler <casey@schaufler-ca.com>
> Reviewed-by: John Johansen <john.johansen@canonical.com>
> ---
>  security/security.c | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
> 
> diff --git a/security/security.c b/security/security.c
> index 2055af907eba..ebbbb672ced5 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -52,12 +52,30 @@ static __initdata bool debug;
>  			pr_info(__VA_ARGS__);			\
>  	} while (0)
> 
> +static void __init ordered_lsm_init(void)
> +{
> +	struct lsm_info *lsm;
> +	int ret;
> +
> +	for (lsm = __start_lsm_info; lsm < __end_lsm_info; lsm++) {
> +		if ((lsm->flags & LSM_FLAG_LEGACY_MAJOR) != 0)
> +			continue;
> +
> +		init_debug("initializing %s\n", lsm->name);
> +		ret = lsm->init();
> +		WARN(ret, "%s failed to initialize: %d\n", lsm->name, ret);
> +	}
> +}
> +
>  static void __init major_lsm_init(void)
>  {
>  	struct lsm_info *lsm;
>  	int ret;
> 
>  	for (lsm = __start_lsm_info; lsm < __end_lsm_info; lsm++) {
> +		if ((lsm->flags & LSM_FLAG_LEGACY_MAJOR) == 0)
> +			continue;
> +
>  		init_debug("initializing %s\n", lsm->name);
>  		ret = lsm->init();
>  		WARN(ret, "%s failed to initialize: %d\n", lsm->name, ret);
> @@ -87,6 +105,9 @@ int __init security_init(void)
>  	yama_add_hooks();
>  	loadpin_add_hooks();
> 
> +	/* Load LSMs in specified order. */
> +	ordered_lsm_init();
> +
>  	/*
>  	 * Load all the remaining security modules.
>  	 */

