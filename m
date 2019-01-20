Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04398C63719
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 09:10:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A52E92085A
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 09:10:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="TYqYyAJJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726872AbfAUJK5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 04:10:57 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:41165 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726738AbfAUJKy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 04:10:54 -0500
Received: by mail-pf1-f194.google.com with SMTP id b7so9835446pfi.8
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jan 2019 01:10:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=dofLV+KRExuHHmlCZM5By72mfegABHdc3g/Ebe8bXFY=;
        b=TYqYyAJJw0SplZ1FXhQmwh9Jc+6PanE4HRTqWExfq0SSa2xZCaQCFmM4anR1BQmnwV
         +W4mraJQ6eF8s8OIfW+nm1e90vr4dojOGIKZ2pIPGDhWdnl7JIBvodIQhXooxE4rdBXf
         IwyO9eHofy9eXyKjSGbhSm3HHPKN5by/B4CO7cyU6g0g6RxzXM8GhujhE+LwHHGSh7JO
         mOS7oNCYezY20t0+ME4md1IemkaxDZJD6hKAOzulXQi0JsfoBUgNHGt0Ft+v42YhMjaO
         4A47hDBA8NFfkJmEEvqfEeXP6GM4XtTYvpZNmuglIgtN9rjnHAtyLWuDk2IfA/O9z+EV
         /0Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=dofLV+KRExuHHmlCZM5By72mfegABHdc3g/Ebe8bXFY=;
        b=L0FyMA9rVS6mQ4mJ6/lhgQfxR+pfsB1OSGJ7ZcAFLKkHGkSAWS9AOpzrCyatWmcs5p
         4RUmQpJXkd8EkkaUad+U8XQQ1rps0ZpSzIrVkUb2dI6HB/ZnJho8gL9bAV5NL5AYHSqN
         em0Qy/eSoXVNdR6KFyu7L3xu//u0a6hkMPfelGgkdeX/FPa88SBOaesI1iQ3kI+XbUKr
         2OzJ+/FbKSfd8yiIuX/EPuZ/bkIlu6nLJtog5924S2yb9UBkFe8X3FADW78h2JRO0wYs
         rjSOazJGknMj2ulhpT52l60gA6SMAISyY39W0KjxIht/zIKRI3W8XvDPrUDrWfQC9rlx
         NovA==
X-Gm-Message-State: AJcUukeDTu0jmfL9dPTsNeYL0/qbqZ9ePLdZ7vl64AwHf39UcqMaC036
        BfdAqIpAk0M3F+9C/AXD97mVz6NgL3E=
X-Google-Smtp-Source: ALg8bN6cRdClRCZgLOYTtiWPGjd0B19WfPOq1CzahCBsaelQlFagmDvd2dnULciJzqH+4zggL/p+nw==
X-Received: by 2002:a63:1f1c:: with SMTP id f28mr25876852pgf.193.1548020453625;
        Sun, 20 Jan 2019 13:40:53 -0800 (PST)
Received: from ?IPv6:2600:1010:b061:5bbf:f93b:211a:989:48d5? ([2600:1010:b061:5bbf:f93b:211a:989:48d5])
        by smtp.gmail.com with ESMTPSA id m20sm11951615pgv.93.2019.01.20.13.40.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 20 Jan 2019 13:40:52 -0800 (PST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v2 3/3] x86/umwait: Control umwait maximum time
From:   Andy Lutomirski <luto@amacapital.net>
X-Mailer: iPhone Mail (16C101)
In-Reply-To: <ae8d5a07-9fbc-7c76-fa88-ff2718696686@citrix.com>
Date:   Sun, 20 Jan 2019 13:40:50 -0800
Cc:     Andy Lutomirski <luto@kernel.org>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>,
        H Peter Anvin <hpa@zytor.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>, x86 <x86@kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <00B78ADC-546A-4738-AB29-B35FD0ECBB88@amacapital.net>
References: <1547673522-226408-1-git-send-email-fenghua.yu@intel.com> <1547673522-226408-4-git-send-email-fenghua.yu@intel.com> <CALCETrVenEpKH5O=Z6J+faWTcdZpa1xx4-dYwdWu1OSEDyiUWw@mail.gmail.com> <ae8d5a07-9fbc-7c76-fa88-ff2718696686@citrix.com>
To:     Andrew Cooper <andrew.cooper3@citrix.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Jan 20, 2019, at 11:12 AM, Andrew Cooper <andrew.cooper3@citrix.com> wr=
ote:
>=20
>> On 17/01/2019 00:00, Andy Lutomirski wrote:
>>> On Wed, Jan 16, 2019 at 1:24 PM Fenghua Yu <fenghua.yu@intel.com> wrote:=

>>> IA32_UMWAIT_CONTROL[31:2] determines the maximum time in TSC-quanta
>>> that processor can stay in C0.1 or C0.2.
>>>=20
>>> The maximum time value in IA32_UMWAIT_CONTROL[31-2] is set as zero which=

>>> means there is no global time limit for UMWAIT and TPAUSE instructions.
>>> Each process sets its own umwait maximum time as the instructions operan=
d.
>>>=20
>>> User can specify global umwait maximum time through interface:
>>> /sys/devices/system/cpu/umwait_control/umwait_max_time
>>> The value in the interface is in decimal in TSC-quanta. Bits[1:0]
>>> are cleared when the value is stored.
>>>=20
>>> Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
>>> ---
>>> arch/x86/include/asm/msr-index.h |  2 ++
>>> arch/x86/power/umwait.c          | 42 +++++++++++++++++++++++++++++++-
>>> 2 files changed, 43 insertions(+), 1 deletion(-)
>>>=20
>>> diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr=
-index.h
>>> index b56bfecae0de..42b9104fc15b 100644
>>> --- a/arch/x86/include/asm/msr-index.h
>>> +++ b/arch/x86/include/asm/msr-index.h
>>> @@ -62,6 +62,8 @@
>>> #define MSR_IA32_UMWAIT_CONTROL                0xe1
>>> #define UMWAIT_CONTROL_C02_BIT         0x0
>>> #define UMWAIT_CONTROL_C02_MASK                0x00000001
>>> +#define UMWAIT_CONTROL_MAX_TIME_BIT    0x2
>>> +#define UMWAIT_CONTROL_MAX_TIME_MASK   0xfffffffc
>>>=20
>>> #define MSR_PKG_CST_CONFIG_CONTROL     0x000000e2
>>> #define NHM_C3_AUTO_DEMOTE             (1UL << 25)
>>> diff --git a/arch/x86/power/umwait.c b/arch/x86/power/umwait.c
>>> index 95b3867aac1e..4a1a507d3bb7 100644
>>> --- a/arch/x86/power/umwait.c
>>> +++ b/arch/x86/power/umwait.c
>>> @@ -10,6 +10,7 @@
>>> #include <asm/msr.h>
>>>=20
>>> static int umwait_enable_c0_2 =3D 1; /* 0: disable C0.2. 1: enable C0.2.=
 */
>>> +static u32 umwait_max_time; /* In TSC-quanta. Only bits [31:2] are used=
. */
>>> static DEFINE_MUTEX(umwait_lock);
>>>=20
>>> /* Return value that will be used to set umwait control MSR */
>>> @@ -20,7 +21,8 @@ static inline u32 umwait_control_val(void)
>>>         * When bit 0 is 1, C0.2 is disabled. Otherwise, C0.2 is enabled.=

>>>         * So value in bit 0 is opposite of umwait_enable_c0_2.
>>>         */
>>> -       return ~umwait_enable_c0_2 & UMWAIT_CONTROL_C02_MASK;
>>> +       return (~umwait_enable_c0_2 & UMWAIT_CONTROL_C02_MASK) |
>>> +              umwait_max_time;
>>> }
>>>=20
>>> static ssize_t umwait_enable_c0_2_show(struct device *dev,
>>> @@ -61,8 +63,46 @@ static ssize_t umwait_enable_c0_2_store(struct device=
 *dev,
>>>=20
>>> static DEVICE_ATTR_RW(umwait_enable_c0_2);
>>>=20
>>> +static ssize_t umwait_max_time_show(struct device *kobj,
>>> +                                   struct device_attribute *attr, char *=
buf)
>>> +{
>>> +       return sprintf(buf, "%u\n", umwait_max_time);
>>> +}
>>> +
>>> +static ssize_t umwait_max_time_store(struct device *kobj,
>>> +                                    struct device_attribute *attr,
>>> +                                    const char *buf, size_t count)
>>> +{
>>> +       u32 msr_val, max_time;
>>> +       int cpu, ret;
>>> +
>>> +       ret =3D kstrtou32(buf, 10, &max_time);
>>> +       if (ret)
>>> +               return ret;
>>> +
>>> +       mutex_lock(&umwait_lock);
>>> +
>>> +       /* Only get max time value from bits [31:2] */
>>> +       max_time &=3D UMWAIT_CONTROL_MAX_TIME_MASK;
>>> +       /* Update the max time value in memory */
>>> +       umwait_max_time =3D max_time;
>>> +       msr_val =3D umwait_control_val();
>>> +       get_online_cpus();
>>> +       /* All CPUs have same umwait max time */
>>> +       for_each_online_cpu(cpu)
>>> +               wrmsr_on_cpu(cpu, MSR_IA32_UMWAIT_CONTROL, msr_val, 0);
>>> +       put_online_cpus();
>>> +
>>> +       mutex_unlock(&umwait_lock);
>>> +
>>> +       return count;
>>> +}
>>> +
>>> +static DEVICE_ATTR_RW(umwait_max_time);
>>> +
>>> static struct attribute *umwait_attrs[] =3D {
>>>        &dev_attr_umwait_enable_c0_2.attr,
>>> +       &dev_attr_umwait_max_time.attr,
>>>        NULL
>>> };
>> You need something to make sure that newly onlined CPUs get the right
>> value in the MSR.  You also need to make sure you restore it on resume
>> from suspend.  Something like cpu_init() might be the right place.
>>=20
>> Also, as previously discussed, I think we should set the default to
>> something quite small, maybe 100 microseconds.  IMO the goal is to
>> pick a value that is a high enough multiple of the C0.2 entry+exit
>> latency that we get most of the power and SMT resource savings while
>> being small enough that no one things that UMWAIT is more than a
>> glorified, slightly improved, and far more misleading version of REP
>> NOP.
>>=20
>> Andrew, would having Linux default to a small value do much to
>> mitigate your concerns that UMWAIT is problematic for hypervisors?
>=20
> Sadly no - not really.
>=20
> Being an MSR, there is no way the guest kernel is having unfiltered
> access, so the hypervisor can set whatever bound it wishes.
>=20
> For any non-trivial wait period, it would be better for the system as a
> whole to switch to a different vcpu, but the semantics don't allow for
> that.  Shortening the timeout just results in userspace taking over
> again, and most likely concluding that there was an early wakeup and
> going back to sleep.

What I mean is: if Linux makes the timeout short for everyone, then applicat=
ions that use UNWAIT will have to be written with the expectation that they a=
re spinning, so the incidence of problematic cases may drop.

>=20
> More useful semantics would be something similar to pause-loop-exiting
> so we can swap contexts while the processor is logically idle in userspace=
.
>=20
> ~Andrew
