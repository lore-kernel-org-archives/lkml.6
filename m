Return-Path: <prime.zeng@hisilicon.com>
X-Google-Smtp-Source: AH8x227541JAGadwgEq0RD/PZWIWukWah0BRNWrDL96gEWonA2Sdms6zOP2o5USs6hZhzlaSWlC5
ARC-Seal: i=1; a=rsa-sha256; t=1519808422; cv=none;
        d=google.com; s=arc-20160816;
        b=ItVIPSpGsc7Y3CGz/VUvP0u+hu17zANNc4ZumMl3RCMm6pbal9z7UW9JRVK/REz1FU
         fRmx4F5yEcxj38F8Nv2QU13prHeMJNXQV8SZVkvqP4442FMPh9ZgdQLXIw9Dkirwwt0G
         vxTEcvrdYsoxAdq20+xQ8cd/0EhvbbrmVYkbQImWxM2bA91bL0fnBZyR6hNZhImWZiyV
         EMj40EfXro0P6F0ZzAO1zS66XhL0zRbd+KgWlUoDxEuyuu7frm6WYj5GGagUI5MVF5Ev
         st5lX2WHfGsGY/CSPHIzhUYkymvTmD8nZWac8GEr2ZclnTeDSUv/V+zEJzvY2iFBmKfl
         psVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:content-transfer-encoding:content-language
         :accept-language:message-id:date:thread-index:thread-topic:subject
         :cc:to:from:arc-authentication-results;
        bh=0W23LGxzXjrrKI2agoqO9bEDflihh9czO5l+uNB+rw0=;
        b=SGgnQT0AYnBrvZG6pEnOjpu/B+WOM4phoORRqR427sCWYe+s2KzHVEYBoBuOCblmke
         D28vhAXcV12rRgQxEDq5rZRda/e9JnazaB4LWI7RhaNOi8Q5vMehteHOqRiVyX86XMxD
         yBex/gYovP9WC1yJcsC/krWIvcGYnSfFQkGD+Q5dZiQL03vIKzEW1d7xNwMwZQMKfPRQ
         YpbNo5Tb5S7jcBG5WMYEEO967X57DjfIhEgKvMYR+MRSnp8x3w+e5zJD73z8KDrdgSjV
         WZ/dTzD6cpfCBOcKp31k+4EIB6iecr8iZU4pRvD27NrLaehXFyd6B1jCTSoQCIR/QKtH
         jSBw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of prime.zeng@hisilicon.com designates 45.249.212.255 as permitted sender) smtp.mailfrom=prime.zeng@hisilicon.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of prime.zeng@hisilicon.com designates 45.249.212.255 as permitted sender) smtp.mailfrom=prime.zeng@hisilicon.com
From: "Zengtao (B)" <prime.zeng@hisilicon.com>
To: "johnyoun@synopsys.com" <johnyoun@synopsys.com>
CC: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	"linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Possible usb_request leak  in the function
 dwc2_gadget_complete_isoc_request_ddma
Thread-Topic: Possible usb_request leak  in the function
 dwc2_gadget_complete_isoc_request_ddma
Thread-Index: AdOwbyiTacV59nKpS3qRvBzZ8xy5mQ==
Date: Wed, 28 Feb 2018 09:00:13 +0000
Message-ID: <678F3D1BB717D949B966B68EAEB446ED0C861F47@DGGEMM506-MBX.china.huawei.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.67.222.15]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593634636290967368?=
X-GMAIL-MSGID: =?utf-8?q?1593634636290967368?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi johnyoun:

I found a suspected bug, and I am writing to confirm with you.

In the function dwc2_gadget_complete_isoc_request_ddma(drivers/usb/dwc2/gad=
get.c).
Only the first request from the eq queue is processed while maybe there are=
 more than one descriptors done by the HW.

1. Each usb request is associated with a DMA descriptor, but this is not re=
flect in the driver, so when one DMA descriptor is done,=20
we don't know which usb request is done, but I think if only one DMA descri=
ptor is done, we can know that the first USB request in=20
eq queue is done, because the HW DMA descriptor and SW usb request are both=
 in sequence.

2. In the function dwc2_gadget_complete_isoc_request_ddma, we may complete =
more than one DMA descriptor but only the first
Usb request is processed, but in fact, we should all the usb requests assoc=
iated with all the done DMA descriptors.

3. I noticed that each DMA descriptor is configured to report an interrupt,=
 and if each DMA descriptor generate an interrupt, the above
Flow should be ok, but the interrupts can merge and we have used the depdma=
 to figure out the largest finished DMA descriptor index.

Looking forward your reply.

Thank you.=20

Regards
Zengtao=20
