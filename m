Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC833C433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 08:34:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E3382147C
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 08:34:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="GsPmPR31"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E3382147C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389375AbeIUOWd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 10:22:33 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:51566 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727795AbeIUOWd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 10:22:33 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w8L8Y9lH176458;
        Fri, 21 Sep 2018 08:34:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type : in-reply-to;
 s=corp-2018-07-02; bh=zmrGPCPiNjpNGLoUoBk+ZUi59gef//h9vvbVWTlxW8A=;
 b=GsPmPR31lQ53pWqg8XcRs6y9Opk4pyIUGcZmQAo+wFiXFDXOfJF9Bgd/LrgSoR9N8Xsg
 1k0Nk1RpKvF2K5XUzu/3AG2I6DvGweCs2MqXCeVIEAMrJIcFtKsFKzSIrJGRqEb7Dxfw
 yG+HxUGmDnLisceUefi7sE+rn4BeMogmzaf/3iUC30bWyP6uJ3I5WELrMzS3kh6//TPt
 thkLMhYxA66FuJ9m4Gz0tbEC+3VwbWZKWn3BGE0oA78Lks4gjrCKWDbS8hGpYZ8paEUl
 pl89gcjE2dSzeYVKehkbAyqfrud2U0qOff3oS+TsXROUbZVIepDl8PO5DE+bM2q9Oawu 6g== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by userp2130.oracle.com with ESMTP id 2mmkm21s5v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 21 Sep 2018 08:34:39 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w8L8YcmG010622
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 21 Sep 2018 08:34:38 GMT
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w8L8YbfM022802;
        Fri, 21 Sep 2018 08:34:38 GMT
Received: from mwanda (/197.232.248.111)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 21 Sep 2018 01:34:37 -0700
Date:   Fri, 21 Sep 2018 11:34:29 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@01.org, Nayna Jain <nayna@linux.vnet.ibm.com>
Cc:     kbuild-all@01.org, linux-integrity@vger.kernel.org,
        zohar@linux.ibm.com, linux-security-module@vger.kernel.org,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        dhowells@redhat.com, jforbes@redhat.com,
        Nayna Jain <nayna@linux.vnet.ibm.com>
Subject: Re: [PATCH v3 3/6] ima: refactor ima_init_policy()
Message-ID: <20180921083429.c7sikis5bzxdifny@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180919075522.7684-4-nayna@linux.vnet.ibm.com>
User-Agent: NeoMutt/20170609 (1.8.3)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9022 signatures=668707
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1809210090
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nayna,

Thank you for the patch! Perhaps something to improve:

url:    https://github.com/0day-ci/linux/commits/Nayna-Jain/Add-support-for-architecture-specific-IMA-policies/20180920-035110

smatch warnings:
security/integrity/ima/ima_policy.c:489 add_rules() warn: should this be a bitwise op?

# https://github.com/0day-ci/linux/commit/84a2e186f940ebc6c34e6d276e55f665167a5bb8
git remote add linux-review https://github.com/0day-ci/linux
git remote update linux-review
git checkout 84a2e186f940ebc6c34e6d276e55f665167a5bb8
vim +489 security/integrity/ima/ima_policy.c

6f0911a6 Mimi Zohar 2018-04-12  477  
84a2e186 Nayna Jain 2018-09-19  478  static void add_rules(struct ima_rule_entry *entries, int count,
84a2e186 Nayna Jain 2018-09-19  479  		      enum policy_rule_list file)
84a2e186 Nayna Jain 2018-09-19  480  {
84a2e186 Nayna Jain 2018-09-19  481  	int i = 0;
84a2e186 Nayna Jain 2018-09-19  482  
84a2e186 Nayna Jain 2018-09-19  483  	for (i = 0; i < count; i++) {
84a2e186 Nayna Jain 2018-09-19  484  		struct ima_rule_entry *entry;
84a2e186 Nayna Jain 2018-09-19  485  
84a2e186 Nayna Jain 2018-09-19  486  		if (file && IMA_DEFAULT_POLICY)
                                                    ^^^^^^^^^^^^^^^^^^^^^^^^^^
84a2e186 Nayna Jain 2018-09-19  487  			list_add_tail(&entries[i].list, &ima_default_rules);
84a2e186 Nayna Jain 2018-09-19  488  
84a2e186 Nayna Jain 2018-09-19 @489  		if (file && IMA_CUSTOM_POLICY) {
                                                    ^^^^^^^^^^^^^^^^^^^^^^^^^

It does look like it should be "if (file & IMA_CUSTOM_POLICY) {" but I
haven't looked at the context besides what's here in this email.

84a2e186 Nayna Jain 2018-09-19  490  			entry = kmemdup(&entries[i], sizeof(*entry),
84a2e186 Nayna Jain 2018-09-19  491  					GFP_KERNEL);
84a2e186 Nayna Jain 2018-09-19  492  			if (!entry)
84a2e186 Nayna Jain 2018-09-19  493  				continue;
84a2e186 Nayna Jain 2018-09-19  494  
84a2e186 Nayna Jain 2018-09-19  495  			INIT_LIST_HEAD(&entry->list);
84a2e186 Nayna Jain 2018-09-19  496  			list_add_tail(&entry->list, &ima_policy_rules);
84a2e186 Nayna Jain 2018-09-19  497  		}
84a2e186 Nayna Jain 2018-09-19  498  		if (entries[i].action == APPRAISE)
84a2e186 Nayna Jain 2018-09-19  499  			temp_ima_appraise |= ima_appraise_flag(entries[i].func);
84a2e186 Nayna Jain 2018-09-19  500  		if (entries[i].func == POLICY_CHECK)
84a2e186 Nayna Jain 2018-09-19  501  			temp_ima_appraise |= IMA_APPRAISE_POLICY;
84a2e186 Nayna Jain 2018-09-19  502  	}
84a2e186 Nayna Jain 2018-09-19  503  }
84a2e186 Nayna Jain 2018-09-19  504  

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
