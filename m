Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7CFEC46464
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 10:03:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6252020BEC
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 10:03:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6252020BEC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728995AbeHMMpN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 08:45:13 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:33488 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728660AbeHMMpM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 08:45:12 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w7D9whp6090180
        for <linux-kernel@vger.kernel.org>; Mon, 13 Aug 2018 06:03:38 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2ku5we52ck-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 13 Aug 2018 06:03:38 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <srikar@linux.vnet.ibm.com>;
        Mon, 13 Aug 2018 11:03:36 +0100
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 13 Aug 2018 11:03:32 +0100
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w7DA3Vf036503634
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 13 Aug 2018 10:03:31 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C06BE11C064;
        Mon, 13 Aug 2018 13:03:35 +0100 (BST)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EE89611C05B;
        Mon, 13 Aug 2018 13:03:32 +0100 (BST)
Received: from linux.vnet.ibm.com (unknown [9.40.192.68])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with SMTP;
        Mon, 13 Aug 2018 13:03:32 +0100 (BST)
Date:   Mon, 13 Aug 2018 03:03:27 -0700
From:   Srikar Dronamraju <srikar@linux.vnet.ibm.com>
To:     Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Cc:     oleg@redhat.com, rostedt@goodmis.org, mhiramat@kernel.org,
        liu.song.a23@gmail.com, peterz@infradead.org, mingo@redhat.com,
        acme@kernel.org, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, namhyung@kernel.org,
        linux-kernel@vger.kernel.org, ananth@linux.vnet.ibm.com,
        alexis.berlemont@gmail.com, naveen.n.rao@linux.vnet.ibm.com,
        linux-arm-kernel@lists.infradead.org, linux-mips@linux-mips.org,
        linux@armlinux.org.uk, ralf@linux-mips.org, paul.burton@mips.com
Subject: Re: [PATCH v8 3/6] Uprobes: Support SDT markers having reference
 count (semaphore)
Reply-To: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
References: <20180809041856.1547-1-ravi.bangoria@linux.ibm.com>
 <20180809041856.1547-4-ravi.bangoria@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20180809041856.1547-4-ravi.bangoria@linux.ibm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-TM-AS-GCONF: 00
x-cbid: 18081310-4275-0000-0000-000002A90299
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18081310-4276-0000-0000-000037B21A10
Message-Id: <20180813100327.GF44470@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-08-13_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=965 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1808130110
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +
> +static int delayed_uprobe_add(struct uprobe *uprobe, struct mm_struct *mm)
> +{
> +	struct delayed_uprobe *du;
> +
> +	if (delayed_uprobe_check(uprobe, mm))
> +		return 0;
> +
> +	du = kzalloc(sizeof(*du), GFP_KERNEL);
> +	if (!du)
> +		return -ENOMEM;
> +
> +	du->uprobe = uprobe;
> +	du->mm = mm;
> +	list_add(&du->list, &delayed_uprobe_list);
> +	return 0;
> +}
> +

Should we keep the delayed uprobe list per mm?
That way we could avoid the global mutex lock.
And the list to traverse would also be small.


> 
> @@ -378,8 +557,15 @@ static struct uprobe *get_uprobe(struct uprobe *uprobe)
> 
>  static void put_uprobe(struct uprobe *uprobe)
>  {
> -	if (atomic_dec_and_test(&uprobe->ref))
> +	if (atomic_dec_and_test(&uprobe->ref)) {
> +		/*
> +		 * If application munmap(exec_vma) before uprobe_unregister()
> +		 * gets called, we don't get a chance to remove uprobe from
> +		 * delayed_uprobe_list in remove_breakpoint(). Do it here.
> +		 */
> +		delayed_uprobe_remove(uprobe, NULL);

I am not getting this part. If unmap happens before unregister,
why cant we use uprobe_munmap? what am I missing.

>  		kfree(uprobe);
> +	}
>  }
> 

