Return-Path: <daniel@iogearbox.net>
X-Google-Smtp-Source: AIpwx4+VHV3+M/3+nkka6va6DNsyYPxy8natkCwAK2r3BtNkAbUdneMpCn8AcTDDrGsvcKoHReLy
ARC-Seal: i=1; a=rsa-sha256; t=1523261670; cv=none;
        d=google.com; s=arc-20160816;
        b=hg04XHQ82JYu7SHUf75QuT0dYOibqsb7nlqQq8wmQaSLhiImfFBxQMdOW/EtgD86bd
         Bf2s4knaDmulewO5cGBEKL1n5grxp0P5wzlao2ebEZhd70xV53FUyqWfrFCKIKnhfc7o
         hYNuo9GWlJmmiXGF6M7djbiCEiwO2M1BTxo5uSwk6O0nh9KTOD7z8CKpUpojrkSZ7Ux9
         Kqn/Se1OE1NwGdA31LSRtV/IDk3pqk/tOTjqnYb7NBLVxwHtAo6RP3GxTyL0VyparSM2
         7vfnJHIE8I0R/zGqHpA7RD4/jT8CfdKMN1hjvFQf/gQqNxI3pzNyPveQwbxYTptw94YZ
         X3GQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :arc-authentication-results;
        bh=bqo450n//907qmUsvnv3cJQyNJEMeRysKUgNFJDbNzQ=;
        b=XpIEi0U319yJKiEjx1uqNH8h+I6F1XadbXNKNBiUL38ZxcD1GXlCEA29jGyKVyS+7c
         9Kl/tBMoqGoDily+b4gLtXVQfXwcN7m+vZCd+cyfdDa0/GMHX5nTzuU0+nVD9sgq61K4
         BHtF2rNk9IiFmM+V6SapzCCxLHF0kG0aU/9K295foXK35j5g8eTUhuBOpQQRGDMPloBx
         3sUiqJn9pr8YVUb8uUhfxwcjgocjiQjU0hzh3/NiRs7GLYWFXs3hAxRdTqjWkGG4KiPm
         MvlBmW18LQnqS7aRiW26R8HroxjUT3zQn/EqoPfw+cw1+ijCYUMuyDkDD640L2lA9O6f
         MH2g==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of daniel@iogearbox.net designates 213.133.104.62 as permitted sender) smtp.mailfrom=daniel@iogearbox.net
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of daniel@iogearbox.net designates 213.133.104.62 as permitted sender) smtp.mailfrom=daniel@iogearbox.net
Subject: Re: [GIT PULL] Kernel lockdown for secure boot
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, joeyli <jlee@suse.com>
Cc: Andy Lutomirski <luto@kernel.org>, David Howells <dhowells@redhat.com>,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>, James Morris
 <jmorris@namei.org>, One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Matthew Garrett <mjg59@google.com>, Greg KH <gregkh@linuxfoundation.org>,
 LKML <linux-kernel@vger.kernel.org>, Justin Forbes <jforbes@redhat.com>,
 linux-man <linux-man@vger.kernel.org>,
 LSM List <linux-security-module@vger.kernel.org>,
 Linux API <linux-api@vger.kernel.org>, Kees Cook <keescook@chromium.org>,
 linux-efi <linux-efi@vger.kernel.org>
References: <CAADnVQLu5EZLJ1C9-dd4=K+sed6+38oy047+nqCMfuPFB=wttw@mail.gmail.com>
 <20180408080742.GE7362@linux-l9pv.suse>
 <20180409034008.dyte7k5kgkbjh5is@ast-mbp.dhcp.thefacebook.com>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <9040da29-2803-5c00-d47c-ae676a86b65c@iogearbox.net>
Date: Mon, 9 Apr 2018 10:14:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20180409034008.dyte7k5kgkbjh5is@ast-mbp.dhcp.thefacebook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcSW1wb3J0YW50Ig==?=
X-GMAIL-THRID: =?utf-8?q?1596848216178927191?=
X-GMAIL-MSGID: =?utf-8?q?1597255629144406285?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 04/09/2018 05:40 AM, Alexei Starovoitov wrote:
> On Sun, Apr 08, 2018 at 04:07:42PM +0800, joeyli wrote:
[...]
>>> If the only thing that folks are paranoid about is reading
>>> arbitrary kernel memory with bpf_probe_read() helper
>>> then preferred patch would be to disable it during verification
>>> when in lockdown mode
>>
>> Sorry for I didn't fully understand your idea...
>> Do you mean that using bpf verifier to filter out bpf program that
>> uses bpf_probe_read()?
> 
> Take a look bpf_get_trace_printk_proto().
> Similarly we can add bpf_get_probe_read_proto() that
> will return NULL if lockdown is on.
> Then programs with bpf_probe_read() will be rejected by the verifier.

Fully agree with the above. For the two helpers, something like the below
would be sufficient to reject progs at verification time.

diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index d88e96d..51a6c2e 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -117,6 +117,11 @@ static const struct bpf_func_proto bpf_probe_read_proto = {
 	.arg3_type	= ARG_ANYTHING,
 };

+static const struct bpf_func_proto *bpf_get_probe_read_proto(void)
+{
+	return kernel_is_locked_down("BPF") ? NULL : &bpf_probe_read_proto;
+}
+
 BPF_CALL_3(bpf_probe_write_user, void *, unsafe_ptr, const void *, src,
 	   u32, size)
 {
@@ -282,6 +287,9 @@ static const struct bpf_func_proto bpf_trace_printk_proto = {

 const struct bpf_func_proto *bpf_get_trace_printk_proto(void)
 {
+	if (kernel_is_locked_down("BPF"))
+		return NULL;
+
 	/*
 	 * this program might be calling bpf_trace_printk,
 	 * so allocate per-cpu printk buffers
@@ -535,7 +543,7 @@ tracing_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 	case BPF_FUNC_map_delete_elem:
 		return &bpf_map_delete_elem_proto;
 	case BPF_FUNC_probe_read:
-		return &bpf_probe_read_proto;
+		return bpf_get_probe_read_proto();
 	case BPF_FUNC_ktime_get_ns:
 		return &bpf_ktime_get_ns_proto;
 	case BPF_FUNC_tail_call:
