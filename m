Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FDA8C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 16:33:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6BE520661
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 16:33:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6BE520661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967050AbeFSQdd (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 12:33:33 -0400
Received: from mga04.intel.com ([192.55.52.120]:65523 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966368AbeFSQdc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 12:33:32 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Jun 2018 09:33:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,243,1526367600"; 
   d="scan'208";a="48287789"
Received: from rchatre-mobl.amr.corp.intel.com (HELO [10.24.14.129]) ([10.24.14.129])
  by fmsmga007.fm.intel.com with ESMTP; 19 Jun 2018 09:33:31 -0700
Subject: Re: [PATCH V6 07/38] x86/intel_rdt: Initialize new resource group
 with sane defaults
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     fenghua.yu@intel.com, tony.luck@intel.com,
        vikas.shivappa@linux.intel.com, gavin.hindman@intel.com,
        jithu.joseph@intel.com, dave.hansen@intel.com, mingo@redhat.com,
        hpa@zytor.com, x86@kernel.org, linux-kernel@vger.kernel.org
References: <68030110df15615d95731fd354ff7adfb0476d37.1527593970.git.reinette.chatre@intel.com>
 <44af4ecef879e88ec1b74c5decbf5dccaf998866.1528405422.git.reinette.chatre@intel.com>
 <alpine.DEB.2.21.1806191418460.1684@nanos.tec.linutronix.de>
From:   Reinette Chatre <reinette.chatre@intel.com>
Message-ID: <fa7e3fa0-cf3b-df77-4b45-988ec3420843@intel.com>
Date:   Tue, 19 Jun 2018 09:33:30 -0700
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1806191418460.1684@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,

On 6/19/2018 5:31 AM, Thomas Gleixner wrote:
> On Thu, 7 Jun 2018, Reinette Chatre wrote:
>> +/**
>> + * cbm_ensure_valid - Enforce validity on provided CBM
>> + * @_val:	Candidate CBM
>> + * @r:		RDT resource to which the CBM belongs
>> + *
>> + * The provided CBM represents all cache portions available for use. This
>> + * may be represented by a bitmap that does not consist of contiguous ones
>> + * and thus be an invalid CBM.
>> + * Here the provided CBM is forced to be a valid CBM by only considering
>> + * the first set of contiguous bits as valid and clearing all bits.
>> + * The intention here is to provide a valid default CBM with which a new
>> + * resource group is initialized. The user can follow this with a
>> + * modification to the CBM if the default does not satisfy the
>> + * requirements.
>> + */
>> +static void cbm_ensure_valid(u32 *_val, struct rdt_resource *r)
>> +{
>> +	unsigned long *val = (unsigned long *)_val;
> 
> I'm a bit worried about the u32 to unsigned long case here. I know that
> cbm_len cannot exceed 32, but still. At least it wants a comment.

Will do.

I am planning to add the following to the next version.

-->8--
diff --git a/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c
b/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c
index bef736f6ba2f..7b4a09d81a30 100644
--- a/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c
+++ b/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c
@@ -2285,6 +2285,14 @@ static int mkdir_mondata_all(struct kernfs_node
*parent_kn,
  */
 static void cbm_ensure_valid(u32 *_val, struct rdt_resource *r)
 {
+	/*
+	 * Convert the u32 _val to an unsigned long required by all the bit
+	 * operations within this function. No more than 32 bits of this
+	 * converted value can be accessed because all bit operations are
+	 * additionally provided with cbm_len that is initialized during
+	 * hardware enumeration using five bits from the EAX register and
+	 * thus never can exceed 32 bits.
+	 */
 	unsigned long *val = (unsigned long *)_val;
 	unsigned int cbm_len = r->cache.cbm_len;
 	unsigned long first_bit, zero_bit;


Reinette

