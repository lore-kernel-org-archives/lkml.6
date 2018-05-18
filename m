Return-Path: <jmorris@namei.org>
X-Google-Smtp-Source: AB8JxZpb5hlIlbVGWHtJau77WvIVPVv+qJlyphBTwJjRcgF2RCWLEzut11NLWiQHwfztPQYdPISE
ARC-Seal: i=1; a=rsa-sha256; t=1526663624; cv=none;
        d=google.com; s=arc-20160816;
        b=AB//IdEwsunkF034Swr05y1V+LYPZ5IowkuW0+Q7Y9DnZiYWsFZoqzJgnozUUsm/SK
         jRFPyUfi9oN+SbHL+lcsdlpVMqgzxiPE+dlynPHpmt8PATMrx8j26jre817x4FkZgqcJ
         6a1uzZC8e81tDxSDd/BFbPqY9ouvSv4557qNmjaFt+zmkSdxXqGHhx/KqHJ39bZ/JPrT
         ii+YUjTUOY+/LyDpdPzUYCvQTDL8W8N73bKefeIOLn+yObcV8Gcn7zTADp67ZXyMUqLc
         /G6USjO9seo51wb4Fio4z2nu51f3/8EigYd6VOn+B7RoQkGkbePmtNXHfXXw2dKAUq86
         dzlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:message-id:in-reply-to:subject
         :cc:to:from:date:arc-authentication-results;
        bh=psqXTlNCYMUuvDI7knMIJnx6ZWBd9uMawcn4lPh9d2Y=;
        b=xiIApK91vL7xDMZUqD8w3BA1GKia+z85j4njEqeXLC3CRTyJ7nLkoJY7PnymNcyDzc
         bf7pgKHyWG+D2FUMBhCQ9k/TWezKKBwUs0LBg3sLzyrTEIF+3fXUHXXQovTNs/hw+Dd5
         L1d/UjAa5mz/odkbKBx1toOhYqqpJRZlM+XMZaQZkzOy71oORVwse1ACf98SwRgwkYep
         vTWfZ8vDc/6hC/2pax6DTGdW5oACCmVP0KwK8qTcj0wSbNrdXDDmEe3PeAPHW4wQ9bhQ
         DWgdySC1Uyb+1sDGPtcGFC8t+dUj4Ji1jyvx1RbeJx2Q3JmByM7NwN3Ev4xM1g2HoYJp
         X3kg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of jmorris@namei.org designates 65.99.196.166 as permitted sender) smtp.mailfrom=jmorris@namei.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of jmorris@namei.org designates 65.99.196.166 as permitted sender) smtp.mailfrom=jmorris@namei.org
Date: Sat, 19 May 2018 03:13:37 +1000 (AEST)
From: James Morris <jmorris@namei.org>
To: "Eric W. Biederman" <ebiederm@xmission.com>
cc: Casey Schaufler <casey@schaufler-ca.com>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
        David Howells <dhowells@redhat.com>,
        "Luis R . Rodriguez" <mcgrof@kernel.org>, kexec@lists.infradead.org,
        Andres Rodriguez <andresx7@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH v2 3/9] security: define security_kernel_read_blob()
 wrapper
In-Reply-To: <87y3ghhbws.fsf@xmission.com>
Message-ID: <alpine.LRH.2.21.1805190303100.26396@namei.org>
References: <1526568530-9144-1-git-send-email-zohar@linux.vnet.ibm.com>        <1526568530-9144-4-git-send-email-zohar@linux.vnet.ibm.com>        <74c096ca-1ad1-799e-df3d-7b1b099333a7@schaufler-ca.com> <87y3ghhbws.fsf@xmission.com>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600723179870285580?=
X-GMAIL-MSGID: =?utf-8?q?1600822836684940941?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, 17 May 2018, Eric W. Biederman wrote:

> Nacked-by: "Eric W. Biederman" <ebiederm@xmission.com>
> 
> Nack on this sharing nonsense.  These two interfaces do not share any
> code in their implementations other than the if statement to distinguish
> between the two cases.

Hmm, it's not even doing that.

There's already an if(!file && read_id == X) { } check and this is another 
one being added.

> If we want comprehensible and maintainable code in the security modules
> we need to split these two pieces of functionality apart.

All ima_read is doing in both the old and new case is checking if there's 
no file then if it's a certain operation, returning an error.

To echo Eric and Casey's suggestions, how about changing the name of the 
hook to security_kernel_read_data() ?

Then ima_read_file() can be changed to ima_read_data(), and then instead 
of two if (!file && read_id == X) checks, have:

	if (!file) {
		switch (read_id) {
		}
	}




-- 
James Morris
<jmorris@namei.org>
