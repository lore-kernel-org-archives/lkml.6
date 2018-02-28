Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752428AbeB1MYq (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 07:24:46 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:35682 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752229AbeB1MYp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 07:24:45 -0500
Date: Wed, 28 Feb 2018 04:24:40 -0800
From: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
To: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, linux-kernel@vger.kernel.org, rostedt@goodmis.org,
        mhiramat@kernel.org, ananth@linux.vnet.ibm.com,
        naveen.n.rao@linux.vnet.ibm.com, oleg@redhat.com
Subject: Re: [RFC 2/4] Uprobe: Export few functions / data structures
Reply-To: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
References: <20180228075345.674-1-ravi.bangoria@linux.vnet.ibm.com>
 <20180228075345.674-3-ravi.bangoria@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20180228075345.674-3-ravi.bangoria@linux.vnet.ibm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-TM-AS-GCONF: 00
x-cbid: 18022812-0016-0000-0000-0000052ACB02
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18022812-0017-0000-0000-00002866FC9C
Message-Id: <20180228122440.GC63063@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-28_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1802280150
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> @@ -149,6 +155,11 @@ struct uprobes_state {
>  extern bool arch_uprobe_ignore(struct arch_uprobe *aup, struct pt_regs *regs);
>  extern void arch_uprobe_copy_ixol(struct page *page, unsigned long vaddr,
>  					 void *src, unsigned long len);
> +unsigned long offset_to_vaddr(struct vm_area_struct *vma, loff_t offset);
> +void copy_from_page(struct page *page, unsigned long vaddr, void *dst, int len);
> +void copy_to_page(struct page *page, unsigned long vaddr, const void *src, int len);
> +struct uprobe_map_info *free_uprobe_map_info(struct uprobe_map_info *info);
> +
>  #else /* !CONFIG_UPROBES */

If we have to export the above, we might have to work with mm maintainers and
see if we can move them there.

> -static inline struct uprobe_map_info *
> -free_uprobe_map_info(struct uprobe_map_info *info)
> +struct uprobe_map_info *free_uprobe_map_info(struct uprobe_map_info *info)
>  {
>  	struct uprobe_map_info *next = info->next;
>  	kfree(info);
>  	return next;
>  }
> 
> -static struct uprobe_map_info *
> -build_uprobe_map_info(struct address_space *mapping, loff_t offset,
> -		      bool is_register)
> +struct uprobe_map_info *build_uprobe_map_info(struct address_space *mapping,
> +					      loff_t offset, bool is_register)
>  {
>  	unsigned long pgoff = offset >> PAGE_SHIFT;
>  	struct vm_area_struct *vma;

Instead of exporting, did you look at extending the uprobe consumer with
ops. i.e if the consumer detects that a probe is a semaphore and exports
a set of callbacks which can them be called from uprobe
insertion/deletion time. With such a thing, incrementing/decrementing
the semaphore and the insertion/deletion of the breakpoint can be done
at one shot. No?
