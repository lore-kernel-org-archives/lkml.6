Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 536DEC46460
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 13:27:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15E6F21D69
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 13:27:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15E6F21D69
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732270AbeHIPwB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 11:52:01 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:44934 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730419AbeHIPwB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 11:52:01 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w79DOBoB063336
        for <linux-kernel@vger.kernel.org>; Thu, 9 Aug 2018 09:27:06 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2krmxsvd38-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 09 Aug 2018 09:27:05 -0400
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <srikar@linux.vnet.ibm.com>;
        Thu, 9 Aug 2018 14:27:03 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 9 Aug 2018 14:27:01 +0100
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w79DR0SY21758152
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 9 Aug 2018 13:27:00 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2CE7842041;
        Thu,  9 Aug 2018 16:27:08 +0100 (BST)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 304AC4203F;
        Thu,  9 Aug 2018 16:27:06 +0100 (BST)
Received: from linux.vnet.ibm.com (unknown [9.40.192.68])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with SMTP;
        Thu,  9 Aug 2018 16:27:06 +0100 (BST)
Date:   Thu, 9 Aug 2018 06:26:57 -0700
From:   Srikar Dronamraju <srikar@linux.vnet.ibm.com>
To:     "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Michael Neuling <mikey@neuling.org>,
        Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>,
        Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>,
        Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>,
        "Oliver O'Halloran" <oohall@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Murilo Opsfelder Araujo <muriloo@linux.ibm.com>,
        Anton Blanchard <anton@samba.org>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 2/2] powerpc: Use cpu_smallcore_sibling_mask at SMT
 level on bigcores
Reply-To: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
References: <1533792728-6304-1-git-send-email-ego@linux.vnet.ibm.com>
 <1533792728-6304-3-git-send-email-ego@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <1533792728-6304-3-git-send-email-ego@linux.vnet.ibm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-TM-AS-GCONF: 00
x-cbid: 18080913-0020-0000-0000-000002B4664F
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18080913-0021-0000-0000-000021017A06
Message-Id: <20180809132657.GA42474@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-08-09_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1808090140
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Gautham R. Shenoy <ego@linux.vnet.ibm.com> [2018-08-09 11:02:08]:

> 
> 3) ppc64_cpu --smt=2
>    SMT domain ceases to exist as each domain consists of just one
>    group.
> 

When seen in isolation, the above looks as if ppc64_cpu --smt=2 o/p says
" SMT domain ceases to exist...."

> @@ -999,7 +1012,17 @@ static void add_cpu_to_masks(int cpu)
>  {
>  	int first_thread = cpu_first_thread_sibling(cpu);
>  	int chipid = cpu_to_chip_id(cpu);
> -	int i;
> +
> +	struct thread_groups tg;
> +	int i, cpu_group_start = -1;
> +
> +	if (has_big_cores) {
> +		struct device_node *dn = of_get_cpu_node(cpu, NULL);
> +

Not checking for validity of dn and no of_node_puts?

> +		parse_thread_groups(dn, &tg);
> +		cpu_group_start = get_cpu_thread_group_start(cpu, &tg);
> +		cpumask_set_cpu(cpu, cpu_smallcore_sibling_mask(cpu));
> +	}
> 
>  	/*
>  	 * This CPU will not be in the online mask yet so we need to manually

The rest looks good

