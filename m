Return-Path: <mingo.kernel.org@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1518537368; cv=none;
        d=google.com; s=arc-20160816;
        b=H8xusRwrmbvnBOYlV8gaHmxAqXeh9wu8dGRVt/DNGbScLaTr0tgllzi/LuSi9ZSlIY
         uvmnNsXu+dkBjUkXm8b/2Y5uRSV5OYs7VFIcw5MqLGuMsaIF2ldvdHP1CBHKVBB3npTo
         AcN3HJDO+dRO6vcrtPS89qMOEgmSn6ciadeAKnRYSW3pKehadrQO9JbwKORwQ3LF5C5W
         E6Z2idflvmxhPSNAg4HcAu0mhiJI9RtTxd1Qr/9hz/SbfsrYLcoV7i0lz1JH8Bt1Nlwl
         gvp4OOIlce6XmTATVwmmGSHfHvBhYOP2Fc6AGjmLwuwSLgqDGpGhJUuSoRmB6IwxoKuB
         wrxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:sender:dkim-signature
         :arc-authentication-results;
        bh=OBnuP/IjejmTkm9q7h9AWNKNeYaTEcr+yl4aBJ4Q060=;
        b=T4e7KhuIpSINceidbmPQgCTbIhPySmSbHE2vlq+FKVMSKyylPsQETKcEA9jfLNAVYh
         RxjnBKfCRE9AVbx0673CpuYWG+8yGU+TsGkis1i+qOIq1NFQdq1yrJ26y/w4J5S8E7SL
         D/89ap/vv/bXtoYvM1LPIzHOMkyPD8lW5I6J1UnOuXBgJOrJzoCBfJH1HW2v1EZdQnwC
         x11E3eieG4D55qS+yJowvjtlWJ7WCsecNkoSMfjtUeinjwHU9C8fQ13Y9/RtPt2xlpXz
         NDdFp3nc3WqOYXnNbKA0R6zMRzeuQFXwIrNHLJbyg8F6VwbwzJg4GOJnvmPIQUoYS0kn
         r6hA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=Ri6uaK46;
       spf=pass (google.com: domain of mingo.kernel.org@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=mingo.kernel.org@gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=Ri6uaK46;
       spf=pass (google.com: domain of mingo.kernel.org@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=mingo.kernel.org@gmail.com
X-Google-Smtp-Source: AH8x2241LVQm6rpFFDUpbdHo9xNQs4Gipn/8j6ib8jgcPaoTesgQoLK+vtAKfHJUEJdtyEVYYNjzxg==
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date: Tue, 13 Feb 2018 16:56:04 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Jia-Ju Bai <baijiaju1990@gmail.com>
Cc: tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, jgross@suse.com,
	douly.fnst@cn.fujitsu.com, kkamagui@gmail.com,
	gregkh@linuxfoundation.org, mka@chromium.org,
	linux-kernel@vger.kernel.org, x86@kernel.org
Subject: Re: [PATCH] kernel: x86: apic: Replace GFP_ATOMIC with GFP_KERNEL in
 __add_pin_to_irq_node
Message-ID: <20180213155604.62ulolc34snh5n3p@gmail.com>
References: <1516758015-7236-1-git-send-email-baijiaju1990@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1516758015-7236-1-git-send-email-baijiaju1990@gmail.com>
User-Agent: NeoMutt/20170609 (1.8.3)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1590435774374304646?=
X-GMAIL-MSGID: =?utf-8?q?1592301839540788299?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


* Jia-Ju Bai <baijiaju1990@gmail.com> wrote:

> The function __add_pin_to_irq_node is not called in atomic context.
> Thus GFP_ATOMIC is not necessary, and it can be replaced with GFP_KERNEL.
> 
> Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
> ---
>  arch/x86/kernel/apic/io_apic.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kernel/apic/io_apic.c b/arch/x86/kernel/apic/io_apic.c
> index 201579d..665c013 100644
> --- a/arch/x86/kernel/apic/io_apic.c
> +++ b/arch/x86/kernel/apic/io_apic.c
> @@ -379,7 +379,7 @@ static int __add_pin_to_irq_node(struct mp_chip_data *data,
>  		if (entry->apic == apic && entry->pin == pin)
>  			return 0;
>  
> -	entry = kzalloc_node(sizeof(struct irq_pin_list), GFP_ATOMIC, node);
> +	entry = kzalloc_node(sizeof(struct irq_pin_list), GFP_KERNEL, node);
>  	if (!entry) {
>  		pr_err("can not alloc irq_pin_list (%d,%d,%d)\n",
>  		       node, apic, pin);

NAK: this is called in an atomic section: with IRQs disabled ...

Thanks,

	Ingo
