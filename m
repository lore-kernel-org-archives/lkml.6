Return-Path: <evgreen@chromium.org>
ARC-Seal: i=1; a=rsa-sha256; t=1526074254; cv=none;
        d=google.com; s=arc-20160816;
        b=wraFIqMdUBC+ib/b29DIYMWgKG3IXkujI4x69NSK6UqFzMgFGRklFwKAiDWdz1RZjN
         t/oFBMWJDDpZ0G5F5ra7PpuxVfoxUU5cOt1yXzmjFWc8h9nzXFij3HMN7VgYcRaMJkby
         TQloNCKvUZrziw/sO1vZTzbVUh3Dr+LDnTDYeLQfwq65raZ6WXlJhQQbL67h3RuC3kbV
         CLPh4haGu3Tsk/5FHblMZyaOYHG82aRgB4WueE16nyGsigTTUVq8s9KHSIFosgZzl0OD
         YbuIDd5oFJTWwNoJ21FiMjhdXRLjBuTxeUKYoBY70w3pxzGaUbXxe3fOk/IMFMFzfYHy
         r7Wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature:arc-authentication-results;
        bh=+8t4OwUEgWaePjPqV7a9v69qYOjenhhrTHDQI+vtA4A=;
        b=wGKgisF+nlR4QdT1IxXhnZyolea/inqqVpcqh/cNif9jqVfedChEYRJwoISqZ52xBn
         ITufeUm9OPwKMunWzeiNWEcmIj9CjLLcsFiso8ppJyYW1Natik4wqo1CTbpk7JEWp9Y5
         Hyk7pk4g1GiMTyuXK78o+wakNOGm29LuUeiiGfvsYKW4PfuHeDzR3MH1zCkSOR0GboTK
         Zw79RoKM3BdaBu2lMnvb1LvOZAO0XtMhipTeh3NWfw0pbc/w71q8jvKzImGlIiHIR349
         E2oLLrs9JspdeFYpSpYUY2z++/Ryo4Ee7kKL/3Op2is5Z6AKORtrexsAZuoiQ3Sy7u8M
         8abQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@chromium.org header.s=google header.b=Wawjk9uY;
       spf=pass (google.com: domain of evgreen@chromium.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=evgreen@chromium.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@chromium.org header.s=google header.b=Wawjk9uY;
       spf=pass (google.com: domain of evgreen@chromium.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=evgreen@chromium.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
X-Google-Smtp-Source: AB8JxZoIRqEHXilVYDT6W19Pj69YG5KbbZrMTI9kkadBdPYB28ZPsBhwyIsoalrRM+j67LkGv1Hbfw==
MIME-Version: 1.0
References: <20180309210958.16672-1-georgi.djakov@linaro.org> <20180309210958.16672-5-georgi.djakov@linaro.org>
In-Reply-To: <20180309210958.16672-5-georgi.djakov@linaro.org>
From: Evan Green <evgreen@chromium.org>
Date: Fri, 11 May 2018 14:30:16 -0700
X-Gmail-Original-Message-ID: <CAE=gft6HTU76M8AqzvN-VeDWE6c8Bgk+TimHHLMfLztWYhCSYQ@mail.gmail.com>
Message-ID: <CAE=gft6HTU76M8AqzvN-VeDWE6c8Bgk+TimHHLMfLztWYhCSYQ@mail.gmail.com>
Subject: Re: [PATCH v4 4/7] interconnect: qcom: Add RPM communication
To: georgi.djakov@linaro.org
Cc: linux-pm@vger.kernel.org, gregkh@linuxfoundation.org, rjw@rjwysocki.net,
	robh+dt@kernel.org, Michael Turquette <mturquette@baylibre.com>, khilman@baylibre.com,
	vincent.guittot@linaro.org, skannan@codeaurora.org,
	Bjorn Andersson <bjorn.andersson@linaro.org>, amit.kucheria@linaro.org,
	seansw@qti.qualcomm.com, davidai@quicinc.com, mark.rutland@arm.com,
	lorenzo.pieralisi@arm.com, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594495926480181904?=
X-GMAIL-MSGID: =?utf-8?q?1600204837379373269?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Mar 9, 2018 at 1:11 PM Georgi Djakov <georgi.djakov@linaro.org>
wrote:

> On some Qualcomm SoCs, there is a remote processor, which controls some of
> the Network-On-Chip interconnect resources. Other CPUs express their needs
> by communicating with this processor. Add a driver to handle comminication
> with this remote processor.

> Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
> ---
>   .../devicetree/bindings/interconnect/qcom-smd.txt  | 31 ++++++++
>   drivers/interconnect/qcom/Makefile                 |  1 +
>   drivers/interconnect/qcom/smd-rpm.c                | 90
++++++++++++++++++++++
>   drivers/interconnect/qcom/smd-rpm.h                | 15 ++++
>   4 files changed, 137 insertions(+)
>   create mode 100644
Documentation/devicetree/bindings/interconnect/qcom-smd.txt
>   create mode 100644 drivers/interconnect/qcom/Makefile
>   create mode 100644 drivers/interconnect/qcom/smd-rpm.c
>   create mode 100644 drivers/interconnect/qcom/smd-rpm.h

> diff --git a/Documentation/devicetree/bindings/interconnect/qcom-smd.txt
b/Documentation/devicetree/bindings/interconnect/qcom-smd.txt
> new file mode 100644
> index 000000000000..14e83ed7019b
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/interconnect/qcom-smd.txt
> @@ -0,0 +1,31 @@
> +Qualcomm SMD-RPM interconnect driver binding
> +------------------------------------------------
> +The RPM is a dedicated hardware engine for managing the shared
> +SoC resources in order to keep the lowest power profile. It
> +communicates with other hardware subsystems via shared memory
> +and accepts requests for various resources.

You never say what RPM or SMD stands for. RPM is Resource Power Manager,
right? But I'm not in the know about SMD. Can you define these somewhere?

-Evan
