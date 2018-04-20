Return-Path: <kvalo@codeaurora.org>
X-Google-Smtp-Source: AIpwx4/Aac0zV9P7xl9h8kE1lkKpQ7LkzjCXqyyLe5DTSQz+QFieRYEIEYeHsS7bG1E260bKv91W
ARC-Seal: i=1; a=rsa-sha256; t=1524220109; cv=none;
        d=google.com; s=arc-20160816;
        b=BV9/NiE9ass2vfZBQu3/8rsMpYdIJxR1+K+n2+tddIrUe3bHfdL0RVyBEQ+0SD/5Rj
         RuN6ffDvNnrVJc6kqSPFZokk+h3XZLpAX8d4O5yR+o4CjIkgHCpmRjCsyvtVrKMPfIuh
         8UGIkrQ6P+J+Mp3Igl5kWVWzrGae/9qJuNOfzaNCNoBKfXPFAldVMgQcvo4+Qr/hQwtR
         jlFG7XqIf47w9QII/l4e9ZNQgEPmHDw7yPgecTrGvgQ5XT68TQYKNfhZv2+Qoytzr+8D
         VO4DStM5Wx72UNLWCoW827W/5C7h2x3dDmr1IzsqXif4bK7/+xmygbq65ddhmq0T9Pcc
         fSAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:dmarc-filter:dkim-signature:dkim-signature
         :arc-authentication-results;
        bh=ipp6bj16wEv2LI0VAwhwFL5YE/Y5CXxXWpWW4R6JMz8=;
        b=HtIBt5yDwyc1FTq9M4R2ZzfSZ1CwW9MYcQkJ43hpW36sAZQLysazQ1knWtlC/PyfEH
         PRq7v6RLi7B7wCipA+T3J2vUDyPUeeGZ2EEPZxuvElEB+kmEhPWGCheKaVVjhDzgl+2m
         yLuGv8uFX7MG5t5lT0vobF5bs7WbfouNoUgv3tbmEwMBALLcs6qt4MLJBDV7Z3/7rD9E
         e5ZvkejE+1ZZ4GBmUaaO89WUWzgnc74rNKMqrEW4yh3nPSeODt9+SS4sroRX0DCESBTa
         MTVAHpdDs2JIuJuTXbTqzVT6Bq7XmBMCHg86OpW2DygsrYRnrQSbLMFgmysqB7wZLt76
         f1qg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=eNTcf8JD;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=eNTcf8JD;
       spf=pass (google.com: domain of kvalo@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=kvalo@codeaurora.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=eNTcf8JD;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=eNTcf8JD;
       spf=pass (google.com: domain of kvalo@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=kvalo@codeaurora.org
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 4561360264
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From: Kalle Valo <kvalo@codeaurora.org>
To: Andres Rodriguez <andresx7@gmail.com>
Cc: linux-kernel@vger.kernel.org,  gregkh@linuxfoundation.org,  mcgrof@kernel.org,  alexdeucher@gmail.com,  ckoenig.leichtzumerken@gmail.com,  arend.vanspriel@broadcom.com
Subject: Re: [PATCH 5/9] firmware: add functions to load firmware without warnings v4
References: <20180417153307.3693-1-andresx7@gmail.com>
	<20180417153307.3693-6-andresx7@gmail.com>
Date: Fri, 20 Apr 2018 13:28:24 +0300
In-Reply-To: <20180417153307.3693-6-andresx7@gmail.com> (Andres Rodriguez's
	message of "Tue, 17 Apr 2018 11:33:03 -0400")
Message-ID: <87d0yui33r.fsf@kamboji.qca.qualcomm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598008015463324966?=
X-GMAIL-MSGID: =?utf-8?q?1598260625424927495?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Andres Rodriguez <andresx7@gmail.com> writes:

> Currently the firmware loader only exposes one silent path for querying
> optional firmware, and that is firmware_request_direct(). This function
> also disables the fallback path, which might not always be the
> desired behaviour. [0]
>
> This patch introduces variations of firmware_request() and
> firmware_request_nowait() that enable the caller to disable the
> undesired warning messages. This is equivalent to adding FW_OPT_NO_WARN,
> to the old behaviour.
>
> v2: add header prototype, use updated opt_flags
> v3: split debug message to separate patch
>     added _nowait variant
>     added documentation
> v4: fix kernel-doc style
>
> [0]: https://git.kernel.org/linus/c0cc00f250e1
>
> Signed-off-by: Andres Rodriguez <andresx7@gmail.com>
> ---
>  .../driver-api/firmware/request_firmware.rst       | 13 ++++--
>  drivers/base/firmware_loader/main.c                | 52 ++++++++++++++++++++--
>  include/linux/firmware.h                           |  6 +++
>  3 files changed, 63 insertions(+), 8 deletions(-)

The changelog should be after the "---" line, this way git-am will
automatically discard it.

-- 
Kalle Valo
