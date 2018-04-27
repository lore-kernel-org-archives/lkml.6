Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757246AbeD0BbZ (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 21:31:25 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:47298 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754672AbeD0BbX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 21:31:23 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Rahul Lakkireddy <rahul.lakkireddy@chelsio.com>
Cc: netdev@vger.kernel.org, kexec@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        davem@davemloft.net, viro@zeniv.linux.org.uk,
        stephen@networkplumber.org, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, ganeshgr@chelsio.com,
        nirranjan@chelsio.com, indranil@chelsio.com
References: <cover.1524329561.git.rahul.lakkireddy@chelsio.com>
        <cover.1524329561.git.rahul.lakkireddy@chelsio.com>
        <1393d2fce1a2c2a0f78431845deae26bc28c16ef.1524329561.git.rahul.lakkireddy@chelsio.com>
Date: Thu, 26 Apr 2018 20:30:58 -0500
In-Reply-To: <1393d2fce1a2c2a0f78431845deae26bc28c16ef.1524329561.git.rahul.lakkireddy@chelsio.com>
        (Rahul Lakkireddy's message of "Sat, 21 Apr 2018 22:35:53 +0530")
Message-ID: <871sf1a10t.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1fBsE4-0000Kd-JU;;;mid=<871sf1a10t.fsf@xmission.com>;;;hst=in01.mta.xmission.com;;;ip=97.119.174.25;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+/ivV5beMLw5lYk+FPBDYuwHpe4xAbOL0=
X-SA-Exim-Connect-IP: 97.119.174.25
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.7 XMSubLong Long Subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4997]
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa07 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa07 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Rahul Lakkireddy <rahul.lakkireddy@chelsio.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 15021 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 2.7 (0.0%), b_tie_ro: 1.89 (0.0%), parse: 0.77 (0.0%),
        extract_message_metadata: 10 (0.1%), get_uri_detail_list: 1.72 (0.0%),
        tests_pri_-1000: 2.9 (0.0%), tests_pri_-950: 1.13 (0.0%), tests_pri_-900:
        0.97 (0.0%), tests_pri_-400: 24 (0.2%), check_bayes: 23 (0.2%), b_tokenize: 8
        (0.1%), b_tok_get_all: 8 (0.1%), b_comp_prob: 2.3 (0.0%), b_tok_touch_all:
        3.5 (0.0%), b_finish: 0.57 (0.0%), tests_pri_0: 1210 (8.1%),
        check_dkim_signature: 0.63 (0.0%), check_dkim_adsp: 3.7 (0.0%),
        tests_pri_500: 13765 (91.6%), poll_dns_idle: 13757 (91.6%), rewrite_mail:
        0.00 (0.0%)
Subject: Re: [PATCH net-next v5 1/3] vmcore: add API to collect hardware dump in second kernel
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


While looking this over I found a bug in the way elf notes are being composed.

Rahul Lakkireddy <rahul.lakkireddy@chelsio.com> writes:
> diff --git a/fs/proc/vmcore.c b/fs/proc/vmcore.c
> index a45f0af22a60..7395462d2f86 100644
> --- a/fs/proc/vmcore.c
> +++ b/fs/proc/vmcore.c
> @@ -1145,6 +1150,132 @@ static int __init parse_crash_elf_headers(void)
>  	return 0;
>  }
>  
> +#ifdef CONFIG_PROC_VMCORE_DEVICE_DUMP
> +/**
> + * vmcoredd_get_note_size - Get size of the note that will be inserted at
> + * beginning of the dump's buffer.
> + * @name: Note's name
> + *
> + * Gets the overall size of the note that will be inserted at the beginning
> + * of the dump's buffer.  It also adds padding, if necessary to meet
> + * alignment requirements.
> + */
> +static inline size_t vmcoredd_get_note_size(const char *name)
> +{
> +	return CRASH_CORE_NOTE_HEAD_BYTES +
> +	       ALIGN(VMCOREDD_NOTE_NAME_BYTES + strlen(name), sizeof(Elf_Word));
> +}
> +
> +/**
> + * vmcoredd_write_note - Write note at the beginning of the dump's buffer
> + * @name: Dump's name
> + * @buf: Output buffer where the note is written
> + * @size: Size of the dump
> + *
> + * Fills beginning of the dump's data with elf note.
> + */
> +static void vmcoredd_write_note(const char *name, void *buf, size_t size)
> +{
> +	struct elf_note *note = (struct elf_note *)buf;
> +	Elf_Word *word = (Elf_Word *)note;
> +
> +	note->n_namesz = ALIGN(VMCOREDD_NOTE_NAME_BYTES + strlen(name),
> +			       sizeof(Elf_Word));
> +	note->n_descsz = size;
> +	note->n_type = NT_VMCOREDD;
> +	word += DIV_ROUND_UP(sizeof(*note), sizeof(Elf_Word));
> +	snprintf((char *)word, note->n_namesz, "%s_%s", VMCOREDD_NOTE_NAME,
> +		 name);

I hate to do this to you but as this is ABI I am going to pick on
this bit of code.

First namesz needs to include the '\0' of the name string.
Second you did not count the length of "_" namesz.
Third name needs to be a vendor identifier.  So "LINUX\0\0\0" in our case.

Which means the device name needs to be in the body of the note.
Perhaps just reserve 32 bytes for the device name?
Perhaps prefix the device name with a length?

The exact layout is whatever you want NT_VMCOREDD to mean.

> diff --git a/include/uapi/linux/elf.h b/include/uapi/linux/elf.h
> index e2535d6dcec7..4e12c423b9fe 100644
> --- a/include/uapi/linux/elf.h
> +++ b/include/uapi/linux/elf.h
> @@ -421,6 +421,7 @@ typedef struct elf64_shdr {
>  #define NT_ARM_SYSTEM_CALL	0x404	/* ARM system call number */
>  #define NT_ARM_SVE	0x405		/* ARM Scalable Vector Extension registers */
>  #define NT_ARC_V2	0x600		/* ARCv2 accumulator/extra registers */
> +#define NT_VMCOREDD	0x700		/* Vmcore Device Dump Note */
>  
>  /* Note header in a PT_NOTE section */
>  typedef struct elf32_note {


Eric
