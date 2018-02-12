Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751315AbeBLFMB (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 00:12:01 -0500
Received: from out01.mta.xmission.com ([166.70.13.231]:57043 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750734AbeBLFMA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 00:12:00 -0500
From: ebiederm@xmission.com (Eric W. Biederman)
To: Dou Liyang <douly.fnst@cn.fujitsu.com>
Cc: Baoquan He <bhe@redhat.com>, <linux-kernel@vger.kernel.org>,
        <mingo@kernel.org>, <tglx@linutronix.de>, <x86@kernel.org>,
        <joro@8bytes.org>, <uobergfe@redhat.com>, <prarit@redhat.com>
References: <20180209121008.28980-1-bhe@redhat.com>
        <caff6f56-d8e3-1c61-e23b-1d335b6771a2@cn.fujitsu.com>
Date: Sun, 11 Feb 2018 23:11:41 -0600
In-Reply-To: <caff6f56-d8e3-1c61-e23b-1d335b6771a2@cn.fujitsu.com> (Dou
        Liyang's message of "Mon, 12 Feb 2018 12:06:10 +0800")
Message-ID: <87wozi7pwy.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1el6PH-0002vI-0f;;;mid=<87wozi7pwy.fsf@xmission.com>;;;hst=in01.mta.xmission.com;;;ip=174.19.85.160;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+03s4Wjuvn/FHBOA68YdZDqCAbAHwh20U=
X-SA-Exim-Connect-IP: 174.19.85.160
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.0 TVD_RCVD_IP Message was received from an IP address
        *  0.7 XMSubLong Long Subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa07 1397; Body=1 Fuz1=1 Fuz2=1]
X-Spam-DCC: XMission; sa07 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Dou Liyang <douly.fnst@cn.fujitsu.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 227 ms - load_scoreonly_sql: 0.03 (0.0%),
        signal_user_changed: 3.0 (1.3%), b_tie_ro: 2.1 (0.9%), parse: 1.04 (0.5%),
        extract_message_metadata: 12 (5.2%), get_uri_detail_list: 1.91 (0.8%),
        tests_pri_-1000: 3.7 (1.6%), tests_pri_-950: 1.14 (0.5%), tests_pri_-900:
        0.96 (0.4%), tests_pri_-400: 21 (9.4%), check_bayes: 20 (9.0%), b_tokenize: 7
        (2.9%), b_tok_get_all: 7 (3.1%), b_comp_prob: 2.1 (0.9%), b_tok_touch_all:
        2.9 (1.3%), b_finish: 0.63 (0.3%), tests_pri_0: 176 (77.6%),
        check_dkim_signature: 0.45 (0.2%), check_dkim_adsp: 2.7 (1.2%),
        tests_pri_500: 4.9 (2.1%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH v3 0/5] x86/apic: Fix restoring boot irq mode in reboot and kexec/kdump
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dou Liyang <douly.fnst@cn.fujitsu.com> writes:

> Hi all,
>
> One thing confused me.
>
> The disconnect_bsp_APIC() may restore the interrupt delivery mode into
> virtual wire mode. it uses the vector F as the spurious interrput, But,
> IMO, using the vector 0xFF(SPURIOUS_APIC_VECTOR) may more suitable and
> will give us more detail. Why the disconnect_bsp_APIC() use vector F
> here?

I would say this needs a documentation search before changing this.

This code originates in:
208fb93162d5 ("[PATCH] kexec: x86_64: restore apic virtual wire mode on shutdown")

The example in the Multi-Processor Specification v1.4 shows setting
up the SPIV to vector 0x0f.

I don't know what is canonical and what will interact best with DOS,
and that erra of setup.  The vector 0x0f seems an odd choice as
it is below 0x20 putting it in the range of vectors that are
reserved for processor exceptions.

The constant SPURIOUS_APIC_VECTOR is definitely not something we want
to be using at this point as that is a linux specific setting and used
when Linux is up and running.  So it is completely inapplicable.

This is all about restoring how the apics were configured at boot time
so it may be appropriate to copy and store this value, if it was not
architectural.

At a practical level at this point I suspect we are ok as the setting
of the SPIV this way has not caused any known problems in the last
decade.   If someone wants to dig through the archtectural documents
and the real world practice and find a better value and explain the
change I would not oppose it.

All I know for certain is using the constant SPURIOUS_APIC_VECTOR
is completely inappropriate (as that constant is about how linux uses
vectors) and thus the patch below is wrong.

> diff --git a/arch/x86/kernel/apic/apic.c b/arch/x86/kernel/apic/apic.c
> index 25ddf02598d2..550deaad6a9a 100644
> --- a/arch/x86/kernel/apic/apic.c
> +++ b/arch/x86/kernel/apic/apic.c
> @@ -2130,7 +2130,7 @@ void disconnect_bsp_APIC(int virt_wire_setup)
>         value = apic_read(APIC_SPIV);
>         value &= ~APIC_VECTOR_MASK;
>         value |= APIC_SPIV_APIC_ENABLED;
> -       value |= 0xf;
> +       value |= SPURIOUS_APIC_VECTOR;
>         apic_write(APIC_SPIV, value);
>
>         if (!virt_wire_setup) {
>

Eric
