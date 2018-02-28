Return-Path: <Minas.Harutyunyan@synopsys.com>
X-Google-Smtp-Source: AH8x227JeBrWwiZZXgebutR4SUJzA9Q+XqQsY7BKkjRVvWG7U9LN2d3c9IsOW3UGWu7cxAUekhst
ARC-Seal: i=1; a=rsa-sha256; t=1519813638; cv=none;
        d=google.com; s=arc-20160816;
        b=Tbh2VW/xd64qVyDxmpNFU0b2ZdRUn1bYy+rJ9yRDCxKzZkyr+LtjsEdDT+hk0Snj6U
         Ld0IAXOmttuWJXs4OlB3dS/3YdYli/OeFus3g2zZG7T3RNYHJJQN30GBD5Y4etwfpPRO
         +KS7LVqalV7sOXw9SkqRtavZ8R27H6p6pV/pNe1yncaUkN1Q38suqh+r8ddfXUgKQ1vT
         ecUPJgJaUIlOaUvLNjeXhlFElfAv0I73SiUrET8YetudM21T0ChgpoRsSNX/hWuu60ax
         gNIq0uDkUfcjr3TFy+jph738Cbk55rly2T62rLhdXgIgxMSashio0Q2IUMWLjYQtvx24
         sQIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:content-transfer-encoding:content-language
         :accept-language:references:message-id:date:thread-index
         :thread-topic:subject:cc:to:from:arc-authentication-results;
        bh=mxh/PsybP+wypGL9zM+e+CAzh0bKA5dVFyv7L1Shzao=;
        b=yGqWdToipvtZk4i5ANoToiXlR8EuUvbrS4amFylpxaxgbtDR94mefTKHp+Sc3xJq3l
         p+QPQcMM2soqHGEhrTpAblMKzRF5zXlYIf31I7rURjciDutVS7i5A+YDc8ZDNkq8wl/y
         Jw4N+pVQ3HuRW3taK1zA6aeZvsKpbZ5CCtYhiuaf/mrjfnUEprR5AsULgHU8O8sxJiFf
         1mebXNWIZabSgTo+Ps3aZikxmku1O4PIyJ+pulTZrjSW9rlurVTrRJdYdLSh600/ogsP
         E/gI69IuhqlDqT0j+tDkv9D4QE2E8930Hbe7RzMCKZR7rsmBeBZ0yYdFfSZuPbkeNTSy
         tI5w==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of minas.harutyunyan@synopsys.com designates 198.182.60.111 as permitted sender) smtp.mailfrom=Minas.Harutyunyan@synopsys.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=synopsys.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of minas.harutyunyan@synopsys.com designates 198.182.60.111 as permitted sender) smtp.mailfrom=Minas.Harutyunyan@synopsys.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=synopsys.com
From: Minas Harutyunyan <Minas.Harutyunyan@synopsys.com>
To: "Zengtao (B)" <prime.zeng@hisilicon.com>, "johnyoun@synopsys.com"
	<John.Youn@synopsys.com>
CC: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	"linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Possible usb_request leak in the function
 dwc2_gadget_complete_isoc_request_ddma
Thread-Topic: Possible usb_request leak in the function
 dwc2_gadget_complete_isoc_request_ddma
Thread-Index: AQHTsH6zU1BbgxUqlUykEmiFUhyGow==
Date: Wed, 28 Feb 2018 10:27:14 +0000
Message-ID: <410670D7E743164D87FA6160E7907A560113A9C13B@am04wembxb.internal.synopsys.com>
References: <678F3D1BB717D949B966B68EAEB446ED0C861F47@DGGEMM506-MBX.china.huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.116.70.62]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593634636290967368?=
X-GMAIL-MSGID: =?utf-8?q?1593640105438866084?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi,=0A=
=0A=
On 2/28/2018 1:00 PM, Zengtao (B) wrote:=0A=
> Hi johnyoun:=0A=
> =0A=
> I found a suspected bug, and I am writing to confirm with you.=0A=
> =0A=
> In the function dwc2_gadget_complete_isoc_request_ddma(drivers/usb/dwc2/g=
adget.c).=0A=
> Only the first request from the eq queue is processed while maybe there a=
re more than one descriptors done by the HW.=0A=
> =0A=
> 1. Each usb request is associated with a DMA descriptor, but this is not =
reflect in the driver, so when one DMA descriptor is done,=0A=
> we don't know which usb request is done, but I think if only one DMA desc=
riptor is done, we can know that the first USB request in=0A=
> eq queue is done, because the HW DMA descriptor and SW usb request are bo=
th in sequence.=0A=
> =0A=
> 2. In the function dwc2_gadget_complete_isoc_request_ddma, we may complet=
e more than one DMA descriptor but only the first=0A=
> Usb request is processed, but in fact, we should all the usb requests ass=
ociated with all the done DMA descriptors.=0A=
> =0A=
> 3. I noticed that each DMA descriptor is configured to report an interrup=
t, and if each DMA descriptor generate an interrupt, the above=0A=
> Flow should be ok, but the interrupts can merge and we have used the depd=
ma to figure out the largest finished DMA descriptor index.=0A=
> =0A=
=0A=
Why you suspect that subsequent interrupts can be merged? Did you see =0A=
this case? Can you provide a log?=0A=
Even in case of minimal interval=3D1, time between 2 subsequent interrupts =
=0A=
should be about 125us. It's fully enough to process target descriptor, =0A=
complete request, enqueue new request and prepare new descriptor.=0A=
=0A=
Thanks,=0A=
Minas=0A=
=0A=
> Looking forward your reply.=0A=
> =0A=
> Thank you.=0A=
> =0A=
> Regards=0A=
> Zengtao=0A=
> --=0A=
> To unsubscribe from this list: send the line "unsubscribe linux-usb" in=
=0A=
> the body of a message to majordomo@vger.kernel.org=0A=
> More majordomo info at  https://urldefense.proofpoint.com/v2/url?u=3Dhttp=
-3A__vger.kernel.org_majordomo-2Dinfo.html&d=3DDwIDAg&c=3DDPL6_X_6JkXFx7AXW=
qB0tg&r=3D6z9Al9FrHR_ZqbbtSAsD16pvOL2S3XHxQnSzq8kusyI&m=3DvbKt9jwY5FRUysFlZ=
g1CB6HKRyFACygkwZBO0mvSQDc&s=3D7rLKr3g3UyOZT22GAer-w5wDtv-Bb5awlncAJQ1OICM&=
e=3D=0A=
> =0A=
=0A=
