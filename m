Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C991C43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 00:52:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D50C62172C
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 00:51:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D50C62172C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727519AbeI1HM7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 03:12:59 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:37864 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726091AbeI1HM6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 03:12:58 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w8S0mqQZ027131
        for <linux-kernel@vger.kernel.org>; Thu, 27 Sep 2018 20:51:56 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2ms7jrmndt-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 27 Sep 2018 20:51:56 -0400
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <zohar@linux.ibm.com>;
        Fri, 28 Sep 2018 01:51:54 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 28 Sep 2018 01:51:50 +0100
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w8S0pnI263045758
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 28 Sep 2018 00:51:50 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3EB215204F;
        Fri, 28 Sep 2018 03:51:30 +0100 (BST)
Received: from localhost.localdomain (unknown [9.80.85.160])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 508ED5204E;
        Fri, 28 Sep 2018 03:51:29 +0100 (BST)
Subject: Re: [PATCH v4 3/6] ima: refactor ima_init_policy()
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Nayna Jain <nayna@linux.vnet.ibm.com>,
        linux-integrity@vger.kernel.org
Cc:     linux-security-module@vger.kernel.org, linux-efi@vger.kernel.org,
        linux-kernel@vger.kernel.org, dhowells@redhat.com,
        jforbes@redhat.com
Date:   Thu, 27 Sep 2018 20:51:38 -0400
In-Reply-To: <20180926122210.14642-4-nayna@linux.vnet.ibm.com>
References: <20180926122210.14642-1-nayna@linux.vnet.ibm.com>
         <20180926122210.14642-4-nayna@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 18092800-0012-0000-0000-000002AF8F14
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18092800-0013-0000-0000-000020E3AF28
Message-Id: <1538095898.3459.140.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-09-27_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1809280007
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nayna,

On Wed, 2018-09-26 at 17:52 +0530, Nayna Jain wrote:

> +static void add_rules(struct ima_rule_entry *entries, int count,
> +		      enum policy_rule_list file)

Using "file" to refer to the policy_rule_list enumeration is unusual.
 Please change the variable name to something more appropriate.

Mimi

> +{
> +	int i = 0;
> +
> +	for (i = 0; i < count; i++) {
> +		struct ima_rule_entry *entry;
> +
> +		if (file & IMA_DEFAULT_POLICY)
> +			list_add_tail(&entries[i].list, &ima_default_rules);
> +
> +		if (file & IMA_CUSTOM_POLICY) {
> +			entry = kmemdup(&entries[i], sizeof(*entry),
> +					GFP_KERNEL);
> +			if (!entry)
> +				continue;
> +
> +			INIT_LIST_HEAD(&entry->list);
> +			list_add_tail(&entry->list, &ima_policy_rules);
> +		}
> +		if (entries[i].action == APPRAISE)
> +			temp_ima_appraise |= ima_appraise_flag(entries[i].func);
> +		if (entries[i].func == POLICY_CHECK)
> +			temp_ima_appraise |= IMA_APPRAISE_POLICY;
> +	}
> +}
> +

