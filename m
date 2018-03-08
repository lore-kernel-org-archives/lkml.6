Return-Path: <kernel-hardening-return-12235-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELshfMuxbI6VvCuOWJEihubCp/g1ErIlvTDkMHXumRojX/opuiF2kr3LUFB5IQMsWhxFfAXl
ARC-Seal: i=1; a=rsa-sha256; t=1520510844; cv=none;
        d=google.com; s=arc-20160816;
        b=vRxwjH3Re/PVPjZ7mR0s6k8hAe3Zr29leLhuf2RjthiRqqdZPjoZxfvOviDlB19TDb
         6Iryfxc/+GivoVu2vDVf/Cfp7SQ3hfE8Nek60gWAS5AFOlclXvQ4pLn5EShPiEc4W6Fy
         tp9sPOjWDQVG84+CXOQPFKVPbIjUkXVGn6IhkRu7e+S0uwes0SRRzVIAKpzoc3ooK0nQ
         PHB0mIHe5fXmSmk43aOqEclgmO/WFIh3inv+m8lEx4PYXIzci1nSpZwyIFWHMSn+XRbz
         dkEEzvJZghnP+IU8QHQre38BE3+8HTW/0ZCiPKlsvA9cd1TEMYhegnhPQlIUljdbGKyo
         7l/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:delivered-to
         :delivered-to:list-id:list-subscribe:list-unsubscribe:list-help
         :list-post:precedence:mailing-list:arc-authentication-results;
        bh=WtMzDiwrg9yD2VeDMjFHjaFDGZd0cDUBtTMpuVMRdPk=;
        b=OkmPdvZxUdBJaO4q1l7qF3Ow8P5x974pzWmlPWIpy8xEhLZO2MsEIuecnNcMvpHf1X
         HOtIurXGsR2iadGiBdFPMaC8BLIBXOfNtAJlqbBVIGDfrRZLgyWDv6xYdJl8xQCJjVMF
         INGp6fdRe2rEK4uDFu/zTpDIyrz0dFcjrOLsBA7Oarrf622miGjFugbZXtK7vjT1LgD3
         LyQB7p4LOaTHyAtEC48NObRpXuVe+ArJZ4HoShDqQPme19gSK7p20oToAnPDDixZbNXa
         ReWOlrOpi6SnopAlIusa4r2dH5EDrhhrjY/iXCz7NX6XD0YNYlUO4eEd++Hz9IsD/9Zs
         vEbw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12235-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12235-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12235-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12235-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
Date: Thu, 8 Mar 2018 12:33:33 +0100
From: David Sterba <dsterba@suse.cz>
To: Kees Cook <keescook@chromium.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	"David S. Miller" <davem@davemloft.net>, gustavo@embeddedor.com,
	Chris Mason <clm@fb.com>, Josef Bacik <jbacik@fb.com>,
	Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
	rostedt@goodmis.org, Peter Zijlstra <peterz@infradead.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	kernel-hardening@lists.openwall.com, corbet@lwn.net,
	Ian Abbott <abbotti@mev.co.uk>,
	Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
	Josh Poimboeuf <jpoimboe@redhat.com>,
	Masahiro Yamada <yamada.masahiro@socionext.com>,
	Petr Mladek <pmladek@suse.com>, Borislav Petkov <bp@suse.de>,
	"Tobin C. Harding" <me@tobin.cc>, linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH 3/3] btrfs: tree-checker: Avoid accidental stack VLA
Message-ID: <20180308113333.GM23693@suse.cz>
Mail-Followup-To: dsterba@suse.cz, Kees Cook <keescook@chromium.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	"David S. Miller" <davem@davemloft.net>, gustavo@embeddedor.com,
	Chris Mason <clm@fb.com>, Josef Bacik <jbacik@fb.com>,
	Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
	rostedt@goodmis.org, Peter Zijlstra <peterz@infradead.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	kernel-hardening@lists.openwall.com, corbet@lwn.net,
	Ian Abbott <abbotti@mev.co.uk>,
	Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
	Josh Poimboeuf <jpoimboe@redhat.com>,
	Masahiro Yamada <yamada.masahiro@socionext.com>,
	Petr Mladek <pmladek@suse.com>, Borislav Petkov <bp@suse.de>,
	"Tobin C. Harding" <me@tobin.cc>, linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org
References: <1520479847-39174-1-git-send-email-keescook@chromium.org>
 <1520479847-39174-4-git-send-email-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1520479847-39174-4-git-send-email-keescook@chromium.org>
User-Agent: Mutt/1.5.23.1 (2014-03-12)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594338759916191449?=
X-GMAIL-MSGID: =?utf-8?q?1594371179480236162?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Mar 07, 2018 at 07:30:47PM -0800, Kees Cook wrote:
> In the quest to remove all stack VLAs from the kernel[1], this refactors
> the stack array size calculation to avoid using max(), which makes the
> compiler think the size isn't fixed.
> 
> [1] https://lkml.org/lkml/2018/3/7/621
> 
> Signed-off-by: Kees Cook <keescook@chromium.org>

Acked-by: David Sterba <dsterba@suse.com>

for whatever name you decide for the max macro.
