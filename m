Return-Path: <jassisinghbrar@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1526225807; cv=none;
        d=google.com; s=arc-20160816;
        b=fgj6E1D7lN9dlN2vUzTb2cGX1B2/LTFaH4cHCVXrUsOdCpV31opVa7RA6wUBx01Ikt
         6vfuwXanNmcggPgKnjtpdhqMdvbViJ6lPMtHV8bKuTlAhOcsMRjJClIkTgqW9OnXgNf0
         Kigwbd3wt+EJnUn0u+UJYgF7mrHvKRnQAj974R14DP3p29Lz4gPX94d2zk18BxB0iuQF
         q+r4HdrJpcLeya/4SG4k36nE0IYmO5UFQpyec2tGrjNskWzAdoev5CTOeulGHlxvTDE8
         4cmbpMgdMpmC/Be717Zha99nj4SqXX4wgIDRIAX3akWNsj6jYf9+vM4qnxqFTkr0l4aM
         V1LA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=GIqLBL8GcKtWvKj5RnLvnxzkzyRZJ7k2K7aaeIOTl4A=;
        b=f/m4Q5K/V5Awkmz1QY1A761q3n2mnmKaHd9Tn30M4ojVnyxeNQT4QC1J4hYYURsWqY
         er/vuOYNX3V45YmWSA8uhByXYeLfp41rNEZsnHAUaD9RCMdZ1YIJvJnjR2A0XV8R27cF
         E76Xxsifmqg6JEmoj54Od4OSUsyy2mpva7yk6GGNmTPZ826NS0xgEcJC7N95myOJh3T1
         oiGF7jCX2gM/GedbUg0zV2HtgrhXNOv81usVodTGVLxKtwYvdsC6vf5iN7TV9cznTrud
         AU8YnDgAv9coMff4USs/CYd3m90CFvrX8ysZrkVzzmXtdaL+JBmxya2uSgLrAiB9TT8O
         4XrA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=Y01T6Ecz;
       spf=pass (google.com: domain of jassisinghbrar@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=jassisinghbrar@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=Y01T6Ecz;
       spf=pass (google.com: domain of jassisinghbrar@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=jassisinghbrar@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AB8JxZoDrCCKjMA90NBDiTzob45nG37uniUZVQIxJHb7qR4JkhLnCCUMHptJ3sYlNIoucnzf5LKNOzGPAZcQdOnyFpE=
MIME-Version: 1.0
In-Reply-To: <20180508114403.14499-7-mperttunen@nvidia.com>
References: <20180508114403.14499-1-mperttunen@nvidia.com> <20180508114403.14499-7-mperttunen@nvidia.com>
From: Jassi Brar <jassisinghbrar@gmail.com>
Date: Sun, 13 May 2018 21:06:46 +0530
Message-ID: <CABb+yY3snB9o4e14by4xui+o_Vhqpe2zh6Pp_e0t-DCTKvMHWA@mail.gmail.com>
Subject: Re: [PATCH 6/8] serial: Add Tegra Combined UART driver
To: Mikko Perttunen <mperttunen@nvidia.com>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	Greg KH <gregkh@linuxfoundation.org>, Thierry Reding <thierry.reding@gmail.com>,
	Jon Hunter <jonathanh@nvidia.com>, araza@nvidia.com,
	Devicetree List <devicetree@vger.kernel.org>, linux-serial@vger.kernel.org,
	linux-tegra@vger.kernel.org,
	", linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, srv_heupstream" <linux-arm-kernel@lists.infradead.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599896478847127946?=
X-GMAIL-MSGID: =?utf-8?q?1600363751796917103?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, May 8, 2018 at 5:14 PM, Mikko Perttunen <mperttunen@nvidia.com> wrote:

....
>
> +config SERIAL_TEGRA_TCU
> +       tristate "NVIDIA Tegra Combined UART"
> +       depends on ARCH_TEGRA && MAILBOX
> +       select SERIAL_CORE
> +       help
> +         Support for the mailbox-based TCU (Tegra Combined UART) serial port.
> +         TCU is a virtual serial port that allows multiplexing multiple data
> +         streams into a single hardware serial port.
> +
Maybe make it depend upon TEGRA_HSP_MBOX ?

......

> +
> +static void tegra_tcu_write(const char *s, unsigned int count)
> +{
> +       struct tegra_tcu *tcu = tegra_tcu_uart_port.private_data;
> +       unsigned int written = 0, i = 0;
> +       bool insert_nl = false;
> +       uint32_t value = 0;
> +
> +       while (i < count) {
> +               if (insert_nl) {
> +                       value |= '\n' << (written++ * 8);
> +                       insert_nl = false;
> +                       i++;
> +               } else if (s[i] == '\n') {
> +                       value |= '\r' << (written++ * 8);
> +                       insert_nl = true;
> +               } else {
> +                       value |= s[i++] << (written++ * 8);
> +               }
> +
> +               if (written == 3) {
> +                       value |= 3 << 24;
> +                       value |= BIT(26);
> +                       mbox_send_message(tcu->tx, &value);
>
How is this supposed to work? tegra_hsp_doorbell_send_data() ignores
the second argument.
