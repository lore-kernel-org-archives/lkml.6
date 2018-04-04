Return-Path: <kernel-hardening-return-12847-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AIpwx49nehlGW5sIzA2JVj/xPwBqueg4/bQ2rJMTW0ApWaBvJp4E8MXqCzCC2MWSeQ1jaymp1X4U
ARC-Seal: i=1; a=rsa-sha256; t=1522835435; cv=none;
        d=google.com; s=arc-20160816;
        b=NkhnE+scd99SGKHeBsJ5kuiyr5RIwTIZ+LwAvwVCKn82UAlsi0eYfrvIi7JG6X02JP
         LFjUr32atQiZPaWxzhrLgFM9V4Spdc+Td4UcggDejKeWBPcvAAxkzig9Qy1l0QMK1Fyx
         X+QLYr72LFyRRgNxF8ohedGryV4XEF0+9Uu+MyNs1kDQ5i1jd+ild9FF7Miai6/vd+Lq
         7M8c0myUFRjNxgy4yPHVRPhU0lkhRowWF/nZ11xw6TXBMDcQTSymu1THowXRjBeB8c3k
         F2FeKUKRmGJkNFUhQrcp4UOybxjwjhEIYSfLWPcBx1nK9yYeo5M4N9/bg+VBvhkaQ0gw
         alkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :references:in-reply-to:mime-version:dkim-signature:delivered-to
         :list-id:list-subscribe:list-unsubscribe:list-help:list-post
         :precedence:mailing-list:arc-authentication-results;
        bh=pavmGDLbiwTEpWQLumeXRacdOhIbEYcMEJkKfvGvXW4=;
        b=TozJw5bgrt+TfnVoD0Q2eiWniqb6Y/HiJceM07QvQD+Qkg0LcqhY1qL9JreS6Mb/zj
         7Ctu7Ye0t/9TS8RqMkO2zhgNE/abIfL2uMqHM2o2BlQW1StItd5ETxYyBfJfNQHrRMSG
         bk0+D6l715an/SO5ls8pODexYr/1LCrYWmBzlma22hyoX1zpBN3hu62f018VfXdoPAzC
         YEMzCak5UFHd14qzOOWRWngV30F3AEkDcIbBinrKYAIb6G2s6yJaBQ4cpI4STdXL+JJ4
         SNqUPFwQGhvZ0ubWjKHycxO3PTqh53hVma8UQy2UT7EjrRRbt+spE7VsTAu1nc3Zy6G1
         Dhvg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=MgWKpnE6;
       spf=pass (google.com: domain of kernel-hardening-return-12847-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12847-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=MgWKpnE6;
       spf=pass (google.com: domain of kernel-hardening-return-12847-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12847-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
MIME-Version: 1.0
In-Reply-To: <4e536889-439a-49e6-dd95-2d4286913202@redhat.com>
References: <1522400006-8859-1-git-send-email-s.mesoraca16@gmail.com> <4e536889-439a-49e6-dd95-2d4286913202@redhat.com>
From: Salvatore Mesoraca <s.mesoraca16@gmail.com>
Date: Wed, 4 Apr 2018 11:49:54 +0200
Message-ID: <CAJHCu1KEuu61_7sWaGtxWgC-3SQeu2cyeFhK0+3s5t3FNNWg9A@mail.gmail.com>
Subject: Re: [v3] crypto: ctr - avoid VLA use
To: Laura Abbott <labbott@redhat.com>
Cc: linux-kernel@vger.kernel.org,
	Kernel Hardening <kernel-hardening@lists.openwall.com>, linux-crypto@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>, Herbert Xu <herbert@gondor.apana.org.au>,
	Kees Cook <keescook@chromium.org>, Eric Biggers <ebiggers3@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596352141229362174?=
X-GMAIL-MSGID: =?utf-8?q?1596808689998897734?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

2018-04-03 23:37 GMT+02:00 Laura Abbott <labbott@redhat.com>:
> On 03/30/2018 01:53 AM, Salvatore Mesoraca wrote:
>> ---
>>   crypto/ctr.c | 15 +++++++++++++--
>>   1 file changed, 13 insertions(+), 2 deletions(-)
>>
>> diff --git a/crypto/ctr.c b/crypto/ctr.c
>> index 854d924..49c469d 100644
>> --- a/crypto/ctr.c
>> +++ b/crypto/ctr.c
>> @@ -21,6 +21,9 @@
>>   #include <linux/scatterlist.h>
>>   #include <linux/slab.h>
>>   +#define MAX_BLOCKSIZE 16
>> +#define MAX_ALIGNMASK 15
>> +
>
>
> Can we pull this out into a header file, I think this would cover
>
> crypto/cipher.c: In function =E2=80=98cipher_crypt_unaligned=E2=80=99:
> crypto/cipher.c:70:2: warning: ISO C90 forbids variable length array
> =E2=80=98buffer=E2=80=99 [-Wvla]
>   u8 buffer[size + alignmask];
>   ^~

Yeah, I'll send a patchset that includes the fix for crypto/cipher.c too.

Thank you for the suggestion :)

Salvatore
