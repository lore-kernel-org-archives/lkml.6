Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756164AbeD3UJ5 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 30 Apr 2018 16:09:57 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:47370 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754555AbeD3UJy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Apr 2018 16:09:54 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Rahul Lakkireddy <rahul.lakkireddy@chelsio.com>
Cc: netdev@vger.kernel.org, kexec@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        davem@davemloft.net, viro@zeniv.linux.org.uk,
        stephen@networkplumber.org, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, ganeshgr@chelsio.com,
        nirranjan@chelsio.com, indranil@chelsio.com
References: <cover.1525082669.git.rahul.lakkireddy@chelsio.com>
Date: Mon, 30 Apr 2018 15:09:30 -0500
In-Reply-To: <cover.1525082669.git.rahul.lakkireddy@chelsio.com> (Rahul
        Lakkireddy's message of "Mon, 30 Apr 2018 15:43:57 +0530")
Message-ID: <87h8ns4ft1.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1fDF78-0003Dr-6y;;;mid=<87h8ns4ft1.fsf@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=97.119.174.25;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+PM7WV61ofnvihravXEBXTUPi53sXYW/o=
X-SA-Exim-Connect-IP: 97.119.174.25
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.7 XMSubLong Long Subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4974]
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa07 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa07 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Rahul Lakkireddy <rahul.lakkireddy@chelsio.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 15021 ms - load_scoreonly_sql: 0.03 (0.0%),
        signal_user_changed: 2.4 (0.0%), b_tie_ro: 1.67 (0.0%), parse: 0.86 (0.0%),
        extract_message_metadata: 10 (0.1%), get_uri_detail_list: 1.60 (0.0%),
        tests_pri_-1000: 2.8 (0.0%), tests_pri_-950: 1.14 (0.0%), tests_pri_-900:
        0.99 (0.0%), tests_pri_-400: 22 (0.1%), check_bayes: 21 (0.1%), b_tokenize: 7
        (0.0%), b_tok_get_all: 8 (0.1%), b_comp_prob: 2.2 (0.0%), b_tok_touch_all:
        2.5 (0.0%), b_finish: 0.51 (0.0%), tests_pri_0: 200 (1.3%),
        check_dkim_signature: 0.48 (0.0%), check_dkim_adsp: 2.9 (0.0%),
        tests_pri_500: 14778 (98.4%), poll_dns_idle: 14770 (98.3%), rewrite_mail:
        0.00 (0.0%)
Subject: Re: [PATCH net-next v6 0/3] kernel: add support to collect hardware logs in crash recovery kernel
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rahul Lakkireddy <rahul.lakkireddy@chelsio.com> writes:

> v6:
> - Reworked device dump elf note name to contain vendor identifier.
> - Added vmcoredd_header that precedes actual dump in the Elf Note.
> - Device dump's name is moved inside vmcoredd_header.
> - Added "CHELSIO" string as vendor identifier in the Elf Note name
>   for cxgb4 device dumps.

Yep you did and that is not correct.  My apologies if I was unclear.

An elf note looks like this:

/* Note header in a PT_NOTE section */
typedef struct elf32_note {
  Elf32_Word	n_namesz;	/* Name size */
  Elf32_Word	n_descsz;	/* Content size */
  Elf32_Word	n_type;		/* Content type */
} Elf32_Nhdr;

n_descsz is is the length of the body.

n_namesz is the length of the ``vendor'' but not the vendor of the your
driver.  It is the ``vendor'' that defines n_type.  So "LINUX" in our
case.

The pair "LINUX", NT_VMCOREDD go together.  That pair is what a
subsequent program must look at to decide how to understand the note.

Please don't use CRASH_CORE_NOTE_HEAD BYTES that obscures things
unnecessarily, and really is not applicable to this use case.
ALIGN(sizeof(struct elf_note), 4) is almost as short and it makes
it clear what your are talking about.


Also please don't look too closely as the other note stuff for Elf core
dumps.  That stuff was not well done from an Elf standards and ABI
perspective.  Unfortunately by the time I had noticed it was years later
so not something that is worth the breakage in tools to change now.

Looking at struct vmcoredd_header.

That seems a reasonable structure.  However it is a uapi structure so
we need to carefully definite it that way.

Perhaps:

#define VMCOREDD_MAX_NAME_BYTES  32

struct vmcoredd_header {
	__u32 header_len;	/* Length of this header */
        __u32 reserved;
        __u64 data_len;		/* Length of this device dump */
        __u8 dump_name[VMCOREDD_MAX_NAME_BYTES];
        __u8 reserved2[16];
};


Looking at that I see another siginficant issue.  We can't let the
device dump be more than 32bits long.  The length of an elf
note is defined by an elf word which is universally a __u32.

So perhaps vmcoredd_header should look like:

#define VMCOREDD_MAX_NAME_BYTES  44

struct vmcoredd_header {
	__u32	n_namesz;	/* Name size */
        __u32	n_descsz;	/* Content size */
        __u32	n_type;		/* NT_VMDOREDD */
	__u8	name[8];	/* LINUX\0\0\0 */
        __u8	dump_name[VMCOREDD_MAX_NAME_BYTES];
};

The total length of the data dump would be descsz - sizeof(struct
vmcoredd_header).  The header winds up being a constant 64 bytes this
way, and includes the elf note header.

Eric
