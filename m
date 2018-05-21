Return-Path: <SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZqldH4qVil9dlPNXSElRo5kD9GedFCYIKr3u+xtRsQhkL8r/+/zGYwmb80d7Xpvxzks9SeH
ARC-Seal: i=1; a=rsa-sha256; t=1526937644; cv=none;
        d=google.com; s=arc-20160816;
        b=WEarQQtxgtALTBRh//hvd8542RQ2UFVo8uMlX+bJdrtU9tFhGCvCXyt20pHbzVA2lV
         WeOz4NWrcyJaWrZ1NdJ1NEzIm5Jl57JgyIxIbMX2VN5ns7a8RkIDE7Iz4AWPViezcUEt
         AxFpNw4+TsmCmBFdmqu9SKXw7+VuhEm50kJHTrUSgtoS2vRaSmKTS2R9jSGyBc1BRnlr
         F6KBril3Ot+DK3PSFKKUhBQio+nkIs0kWxesvZLTc/qNbWMCyDU1/uhhhkCNNPg9ylV5
         Pt/PI9YF9jy2EysTsLo8q4qImz5D/D7DIT9AMsU+mKbgm50SHNF+JCCA9QAKUhDazCGW
         //hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=StgKGzcDuO0ixe6qD7J9Wn5PLynifEoaTBoiVbNBvJg=;
        b=1BuJBJcohJlzMwVeirvQj94nN9QuKVXz52IiW6wiN2Dk4zo+41KeZwxaKHKVrIQc63
         wgAGtxcGbUDUT9PBQS9/tUJtOqSkTTQIkdzXgvqp9i7sMIp6336yfFOCPILz+ddcfmmh
         Ohru3Ubw8fSq2hNvcsbeacDVm9F0pcUfsVpq4wFWcah+6oPIu86QFli7r8G8D32XdU2U
         mdLOgd2Eemv9DQPmdL08dBP6ZwnRnvn+92QVyZISu38oAxdDURetCPY18IQvhpw7n6sU
         o6c+QCvJ0bOaEjGupzeCQpKJ2nI2dOqYhA/FriR5xxlTp7bacD1b71lleCHnnzUYOQFt
         TDMA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=RF0Pz3tf;
       spf=pass (google.com: domain of srs0=nia/=ii=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=RF0Pz3tf;
       spf=pass (google.com: domain of srs0=nia/=ii=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Alexey Izbyshev <izbyshev@ispras.ru>,
	Dmitry Safonov <dima@arista.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Cyrill Gorcunov <gorcunov@openvz.org>,
	Borislav Petkov <bp@suse.de>,
	Alexander Monakov <amonakov@ispras.ru>,
	Dmitry Safonov <0x7f454c46@gmail.com>,
	linux-mm@kvack.org,
	Andy Lutomirski <luto@kernel.org>,
	"H. Peter Anvin" <hpa@zytor.com>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCH 4.14 36/95] x86/mm: Drop TS_COMPAT on 64-bit exec() syscall
Date: Mon, 21 May 2018 23:11:26 +0200
Message-Id: <20180521210455.229365124@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180521210447.219380974@linuxfoundation.org>
References: <20180521210447.219380974@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1601110166565878861?=
X-GMAIL-MSGID: =?utf-8?q?1601110166565878861?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dmitry Safonov <dima@arista.com>

commit acf46020012ccbca1172e9c7aeab399c950d9212 upstream.

The x86 mmap() code selects the mmap base for an allocation depending on
the bitness of the syscall. For 64bit sycalls it select mm->mmap_base and
for 32bit mm->mmap_compat_base.

exec() calls mmap() which in turn uses in_compat_syscall() to check whether
the mapping is for a 32bit or a 64bit task. The decision is made on the
following criteria:

  ia32    child->thread.status & TS_COMPAT
   x32    child->pt_regs.orig_ax & __X32_SYSCALL_BIT
  ia64    !ia32 && !x32

__set_personality_x32() was dropping TS_COMPAT flag, but
set_personality_64bit() has kept compat syscall flag making
in_compat_syscall() return true during the first exec() syscall.

Which in result has user-visible effects, mentioned by Alexey:
1) It breaks ASAN
$ gcc -fsanitize=address wrap.c -o wrap-asan
$ ./wrap32 ./wrap-asan true
==1217==Shadow memory range interleaves with an existing memory mapping. ASan cannot proceed correctly. ABORTING.
==1217==ASan shadow was supposed to be located in the [0x00007fff7000-0x10007fff7fff] range.
==1217==Process memory map follows:
        0x000000400000-0x000000401000   /home/izbyshev/test/gcc/asan-exec-from-32bit/wrap-asan
        0x000000600000-0x000000601000   /home/izbyshev/test/gcc/asan-exec-from-32bit/wrap-asan
        0x000000601000-0x000000602000   /home/izbyshev/test/gcc/asan-exec-from-32bit/wrap-asan
        0x0000f7dbd000-0x0000f7de2000   /lib64/ld-2.27.so
        0x0000f7fe2000-0x0000f7fe3000   /lib64/ld-2.27.so
        0x0000f7fe3000-0x0000f7fe4000   /lib64/ld-2.27.so
        0x0000f7fe4000-0x0000f7fe5000
        0x7fed9abff000-0x7fed9af54000
        0x7fed9af54000-0x7fed9af6b000   /lib64/libgcc_s.so.1
[snip]

2) It doesn't seem to be great for security if an attacker always knows
that ld.so is going to be mapped into the first 4GB in this case
(the same thing happens for PIEs as well).

The testcase:
$ cat wrap.c

int main(int argc, char *argv[]) {
  execvp(argv[1], &argv[1]);
  return 127;
}

$ gcc wrap.c -o wrap
$ LD_SHOW_AUXV=1 ./wrap ./wrap true |& grep AT_BASE
AT_BASE:         0x7f63b8309000
AT_BASE:         0x7faec143c000
AT_BASE:         0x7fbdb25fa000

$ gcc -m32 wrap.c -o wrap32
$ LD_SHOW_AUXV=1 ./wrap32 ./wrap true |& grep AT_BASE
AT_BASE:         0xf7eff000
AT_BASE:         0xf7cee000
AT_BASE:         0x7f8b9774e000

Fixes: 1b028f784e8c ("x86/mm: Introduce mmap_compat_base() for 32-bit mmap()")
Fixes: ada26481dfe6 ("x86/mm: Make in_compat_syscall() work during exec")
Reported-by: Alexey Izbyshev <izbyshev@ispras.ru>
Bisected-by: Alexander Monakov <amonakov@ispras.ru>
Investigated-by: Andy Lutomirski <luto@kernel.org>
Signed-off-by: Dmitry Safonov <dima@arista.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Cyrill Gorcunov <gorcunov@openvz.org>
Cc: Borislav Petkov <bp@suse.de>
Cc: Alexander Monakov <amonakov@ispras.ru>
Cc: Dmitry Safonov <0x7f454c46@gmail.com>
Cc: stable@vger.kernel.org
Cc: linux-mm@kvack.org
Cc: Andy Lutomirski <luto@kernel.org>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Cyrill Gorcunov <gorcunov@openvz.org>
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Link: https://lkml.kernel.org/r/20180517233510.24996-1-dima@arista.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/kernel/process_64.c |    1 +
 1 file changed, 1 insertion(+)

--- a/arch/x86/kernel/process_64.c
+++ b/arch/x86/kernel/process_64.c
@@ -528,6 +528,7 @@ void set_personality_64bit(void)
 	clear_thread_flag(TIF_X32);
 	/* Pretend that this comes from a 64bit execve */
 	task_pt_regs(current)->orig_ax = __NR_execve;
+	current_thread_info()->status &= ~TS_COMPAT;
 
 	/* Ensure the corresponding mm is not marked. */
 	if (current->mm)
