Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59425C61CE3
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 22:22:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E0EC20449
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 22:22:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729974AbfARWWT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 17:22:19 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:38932 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729892AbfARWWS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 17:22:18 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EE51B80D;
        Fri, 18 Jan 2019 14:22:17 -0800 (PST)
Received: from [192.168.100.241] (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 15E893F7BE;
        Fri, 18 Jan 2019 14:22:17 -0800 (PST)
Subject: Re: [PATCH v3 0/7] arm64: add system vulnerability sysfs entries
To:     Stefan Wahren <stefan.wahren@i2se.com>, marc.zyngier@arm.com
Cc:     mlangsdo@redhat.com, suzuki.poulose@arm.com,
        linux-arm-kernel@lists.infradead.org, catalin.marinas@arm.com,
        julien.thierry@arm.com, will.deacon@arm.com,
        linux-kernel@vger.kernel.org, steven.price@arm.com,
        ykaukab@suse.de, dave.martin@arm.com, shankerd@codeaurora.org
References: <20190109235544.2992426-1-jeremy.linton@arm.com>
 <884332236.499392.1547581848222@email.ionos.de>
 <c99f5da9-259c-3fc5-6150-7327ba0ff429@arm.com>
 <575913854.422488.1547834735236@email.ionos.de>
From:   Jeremy Linton <jeremy.linton@arm.com>
Message-ID: <3af70b49-22e7-f394-1b35-ce3c86640bb7@arm.com>
Date:   Fri, 18 Jan 2019 16:22:16 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <575913854.422488.1547834735236@email.ionos.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/18/2019 12:05 PM, Stefan Wahren wrote:
> Hi,
> 
>> Jeremy Linton <jeremy.linton@arm.com> hat am 15. Januar 2019 um 22:21 geschrieben:
>>
>>
>> Hi,
>>
>> On 01/15/2019 01:50 PM, Stefan Wahren wrote:
>>> Hi Jeremy,
>>>
>>>> Jeremy Linton <jeremy.linton@arm.com> hat am 10. Januar 2019 um 00:55 geschrieben:
>>>>
>>>>
>>>> Arm64 machines should be displaying a human readable
>>>> vulnerability status to speculative execution attacks in
>>>> /sys/devices/system/cpu/vulnerabilities
>>>>
>>>> This series enables that behavior by providing the expected
>>>> functions. Those functions expose the cpu errata and feature
>>>> states, as well as whether firmware is responding appropriately
>>>> to display the overall machine status. This means that in a
>>>> heterogeneous machine we will only claim the machine is mitigated
>>>> or safe if we are confident all booted cores are safe or
>>>> mitigated.
>>>>
>>>
>>> i applied this v3 series and Marc's v2 series.
>>>
>>> Now i'm getting the following on a Raspberry Pi 3 B+ :
>>>
>>> meltdown:Not affected
>>> spec_store_bypass:Not affected
>>> spectre_v1:Mitigation: __user pointer sanitization
>>>
>>> So the entries l1tf and spectre_v2 disappeared.
>>
>> Yes, the l1tf entry should be gone.
>>
>> I believe there is a problem with the "1/2 advertise.." patch in that
>> the 'arm64_requested_vuln_attrs |=' line needs to be hoisted  to the top
>> of check_branch_predictor() and the '__spectrev2_safe = false' line
>> needs to be hoisted 6 lines immediately above "/* Fallback to firmware
>> detection*/"
> 
> a snippet or a new version would be nice

Sure, I've got another version, to be posted soon (probably Tue of next 
week).

In the meantime, Marc's tree should work with the following fix:

diff --git a/arch/arm64/kernel/cpu_errata.c b/arch/arm64/kernel/cpu_errata.c
index b44f87e7360d..7cfd34b2c0e5 100644
--- a/arch/arm64/kernel/cpu_errata.c
+++ b/arch/arm64/kernel/cpu_errata.c
@@ -286,11 +286,15 @@ static int detect_harden_bp_fw(void)
  }
  #endif /* CONFIG_HARDEN_BRANCH_PREDICTOR */

+#if defined(CONFIG_ARM64_SSBD) || \
+       defined(CONFIG_GENERIC_CPU_VULNERABILITIES)
+static bool __ssb_safe = true;
+#endif
+
  #ifdef CONFIG_ARM64_SSBD
  DEFINE_PER_CPU_READ_MOSTLY(u64, arm64_ssbd_callback_required);

  int ssbd_state __read_mostly = ARM64_SSBD_KERNEL;
-static bool __ssb_safe = true;

  static const struct ssbd_options {
         const char      *str;
@@ -569,6 +573,8 @@ check_branch_predictor(const struct 
arm64_cpu_capabilities *entry, int scope)

         WARN_ON(scope != SCOPE_LOCAL_CPU || preemptible());

+       arm64_requested_vuln_attrs |= VULN_SPECTREV2;
+
         /* If the CPU has CSV2 set, we're safe */
         if 
(cpuid_feature_extract_unsigned_field(read_cpuid(ID_AA64PFR0_EL1),
                                                  ID_AA64PFR0_CSV2_SHIFT))
@@ -578,17 +584,17 @@ check_branch_predictor(const struct 
arm64_cpu_capabilities *entry, int scope)
         if (is_midr_in_range_list(read_cpuid_id(), spectre_v2_safe_list))
                 return false;

+       __spectrev2_safe = false;
+
         /* Fallback to firmware detection */
         need_wa = detect_harden_bp_fw();
         if (!need_wa)
                 return false;

-       __spectrev2_safe = false;
-
         if (need_wa < 0)
                 pr_warn_once("ARM_SMCCC_ARCH_WORKAROUND_1 missing from 
firmware\n");

-       arm64_requested_vuln_attrs |= VULN_SPECTREV2;
+

         return (need_wa > 0);
  }


