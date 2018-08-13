Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35A9DC4646D
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 12:07:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC583217B8
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 12:07:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC583217B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729707AbeHMOtn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 10:49:43 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:33266 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729643AbeHMOtm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 10:49:42 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w7DC11vb087403
        for <linux-kernel@vger.kernel.org>; Mon, 13 Aug 2018 08:07:42 -0400
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2ku9541gep-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 13 Aug 2018 08:07:42 -0400
Received: from localhost
        by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <ego@linux.vnet.ibm.com>;
        Mon, 13 Aug 2018 06:07:41 -0600
Received: from b03cxnp07028.gho.boulder.ibm.com (9.17.130.15)
        by e32.co.us.ibm.com (192.168.1.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 13 Aug 2018 06:07:37 -0600
Received: from b03ledav003.gho.boulder.ibm.com (b03ledav003.gho.boulder.ibm.com [9.17.130.234])
        by b03cxnp07028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w7DC7aIJ17563698
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 13 Aug 2018 05:07:36 -0700
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B869D6A054;
        Mon, 13 Aug 2018 06:07:36 -0600 (MDT)
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6F8B56A047;
        Mon, 13 Aug 2018 06:07:36 -0600 (MDT)
Received: from sofia.ibm.com (unknown [9.124.35.106])
        by b03ledav003.gho.boulder.ibm.com (Postfix) with ESMTP;
        Mon, 13 Aug 2018 06:07:36 -0600 (MDT)
Received: by sofia.ibm.com (Postfix, from userid 1000)
        id E929F2E3075; Mon, 13 Aug 2018 17:37:32 +0530 (IST)
Date:   Mon, 13 Aug 2018 17:37:32 +0530
From:   Gautham R Shenoy <ego@linux.vnet.ibm.com>
To:     Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Cc:     "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
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
Reply-To: ego@linux.vnet.ibm.com
References: <1533792728-6304-1-git-send-email-ego@linux.vnet.ibm.com>
 <1533792728-6304-3-git-send-email-ego@linux.vnet.ibm.com>
 <20180809132657.GA42474@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180809132657.GA42474@linux.vnet.ibm.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-TM-AS-GCONF: 00
x-cbid: 18081312-0004-0000-0000-000014756DCA
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009535; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01072897; UDB=6.00552766; IPR=6.00852849;
 MB=3.00022686; MTD=3.00000008; XFM=3.00000015; UTC=2018-08-13 12:07:40
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18081312-0005-0000-0000-00008871693B
Message-Id: <20180813120732.GA13369@in.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-08-13_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1808130130
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 09, 2018 at 06:26:57AM -0700, Srikar Dronamraju wrote:
> * Gautham R. Shenoy <ego@linux.vnet.ibm.com> [2018-08-09 11:02:08]:
> 
> > 
> > 3) ppc64_cpu --smt=2
> >    SMT domain ceases to exist as each domain consists of just one
> >    group.
> > 
> 
> When seen in isolation, the above looks as if ppc64_cpu --smt=2 o/p says
> " SMT domain ceases to exist...."

Ok. The intent was to say that one of the sched-domain level
collapses, thereby leaving only CACHE, DIE and NUMA. Will word it
better.

> 
> > @@ -999,7 +1012,17 @@ static void add_cpu_to_masks(int cpu)
> >  {
> >  	int first_thread = cpu_first_thread_sibling(cpu);
> >  	int chipid = cpu_to_chip_id(cpu);
> > -	int i;
> > +
> > +	struct thread_groups tg;
> > +	int i, cpu_group_start = -1;
> > +
> > +	if (has_big_cores) {
> > +		struct device_node *dn = of_get_cpu_node(cpu, NULL);
> > +
> 
> Not checking for validity of dn and no of_node_puts?

Will fix this. Thanks for catching this.

> 
> > +		parse_thread_groups(dn, &tg);
> > +		cpu_group_start = get_cpu_thread_group_start(cpu, &tg);
> > +		cpumask_set_cpu(cpu, cpu_smallcore_sibling_mask(cpu));
> > +	}
> > 
> >  	/*
> >  	 * This CPU will not be in the online mask yet so we need to manually
> 
> The rest looks good

Thanks for the review.


> 

