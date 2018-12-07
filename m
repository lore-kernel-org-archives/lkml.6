Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40DE1C07E85
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 18:53:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3DF22082D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 18:53:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="WJnE4V9e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3DF22082D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726315AbeLGSxO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 13:53:14 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:33695 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726018AbeLGSxO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 13:53:14 -0500
Received: by mail-lf1-f66.google.com with SMTP id i26so3780700lfc.0
        for <linux-kernel@vger.kernel.org>; Fri, 07 Dec 2018 10:53:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KooYbKcRbq1j0mTAbFhnUuKIoqqrZ/SbOhnWxKwPscs=;
        b=WJnE4V9egrFpXkbhN1Yyqdsk0JvEPlfpChIX2R4BmkGCPHrJyDxMs/ENyBTW8F4D/4
         MvBKJPfecLlRSXg4f3FwClgKhCFZlMMarkzbdZf9p14h7wY7rvpJ2gcnTdVT1bmQTeaB
         JcpNs0giaxAiwtWtUnuTLHCn2zRf9aDHF18gM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KooYbKcRbq1j0mTAbFhnUuKIoqqrZ/SbOhnWxKwPscs=;
        b=BLUd+cKGgGQaCVYAWzO6XHW4v5O4dhBCzEXDHekf8YbxdozCBs39+EVudIjH8QkSUu
         b35L3tCo+vsTkurYHxxgp6fNh1Ogj/3rzGU4CoKpseXT3AQbNT83EkLmB7pIxi8F8LgA
         ADgSvbpzlBsbPpllszVXTdjoC8mZ7wRJnCJuSo3q7IHglRijL4VHU0Dl41HO2oYLyGjJ
         F/FEwIJPTrrYMAMl6RsqMv55VUsgAWysQ8kH0i9w8AXWQae8symyU6t3N69mgEy9LJl9
         BDmqktQFs02Z431edLUTa/z+YwKLNzQTNHOceJaTxqSp+fmACUwRsiopRsCdf9xaHju9
         Pwcg==
X-Gm-Message-State: AA+aEWbZIDaCIxJgFkVCCftbObWH8U4FxbkdwwXlvjenVgvtdWjrDK09
        LCRI1iNLcayorj8ZVfhzrVbhbpd57U4=
X-Google-Smtp-Source: AFSGD/VO5YX6Viq983h+xFcczlTsKsBg04Yy0GEg/iGRrQTCxK9Y2Z8Nzc+M05OwfejzeX/+xp6qWg==
X-Received: by 2002:a19:a84e:: with SMTP id r75mr2060062lfe.45.1544208790033;
        Fri, 07 Dec 2018 10:53:10 -0800 (PST)
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com. [209.85.167.47])
        by smtp.gmail.com with ESMTPSA id w9sm730983lfc.66.2018.12.07.10.53.05
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Dec 2018 10:53:06 -0800 (PST)
Received: by mail-lf1-f47.google.com with SMTP id f23so3723420lfc.13
        for <linux-kernel@vger.kernel.org>; Fri, 07 Dec 2018 10:53:05 -0800 (PST)
X-Received: by 2002:a19:cb94:: with SMTP id b142mr2061292lfg.117.1544208785368;
 Fri, 07 Dec 2018 10:53:05 -0800 (PST)
MIME-Version: 1.0
References: <CAHk-=whk_fsnxVMvF1T2fFCaP2WrvSybABrLQCWLJyCvHw6NKA@mail.gmail.com>
 <20181207184423.1962-1-sean.j.christopherson@intel.com>
In-Reply-To: <20181207184423.1962-1-sean.j.christopherson@intel.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 7 Dec 2018 10:52:49 -0800
X-Gmail-Original-Message-ID: <CAHk-=whMhJ84SqnUa0qAV-xkP6ghictLv8RLxOrp8mXKfp5zqQ@mail.gmail.com>
Message-ID: <CAHk-=whMhJ84SqnUa0qAV-xkP6ghictLv8RLxOrp8mXKfp5zqQ@mail.gmail.com>
Subject: Re: [PATCH] x86/fault: Decode and print #PF oops in human readable form
To:     sean.j.christopherson@intel.com
Cc:     dave.hansen@linux.intel.com, Andrew Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, bp@alien8.de,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Peter Anvin <hpa@zytor.com>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Rik van Riel <riel@surriel.com>, yu-cheng.yu@intel.com,
        Ingo Molnar <mingo@kernel.org>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="000000000000205adb057c7320d4"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--000000000000205adb057c7320d4
Content-Type: text/plain; charset="UTF-8"

On Fri, Dec 7, 2018 at 10:44 AM Sean Christopherson
<sean.j.christopherson@intel.com> wrote:
>
> Remove the per-bit decoding of the error code and instead print the raw
> error code followed by a brief description of what caused the fault, the
> effective privilege level of the faulting access, and whether the fault
> originated in user code or kernel code.

This doesn't quite work as-is, though.

For example, at least the PK bit is independent of the other bits and
would be interesting in the human-legible version, but doesn't show up
there at all.

That said, I think the end result might be more legible than the
previous version, so this approach may well be good, it just needs at
least that "permissions violation"  part to be extended with whether
it was PK or not.

Also, shouldn't we show the SGX bit too as some kind of "during SGX"
extension on the "in user/kernel space" part?

                   Linus

--000000000000205adb057c7320d4
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIIT/AYJKoZIhvcNAQcCoIIT7TCCE+kCAQExDzANBglghkgBZQMEAgEFADALBgkqhkiG9w0BBwGg
ghEQMIIF5jCCA86gAwIBAgIQapvhODv/K2ufAdXZuKdSVjANBgkqhkiG9w0BAQwFADCBhTELMAkG
A1UEBhMCR0IxGzAZBgNVBAgTEkdyZWF0ZXIgTWFuY2hlc3RlcjEQMA4GA1UEBxMHU2FsZm9yZDEa
MBgGA1UEChMRQ09NT0RPIENBIExpbWl0ZWQxKzApBgNVBAMTIkNPTU9ETyBSU0EgQ2VydGlmaWNh
dGlvbiBBdXRob3JpdHkwHhcNMTMwMTEwMDAwMDAwWhcNMjgwMTA5MjM1OTU5WjCBlzELMAkGA1UE
BhMCR0IxGzAZBgNVBAgTEkdyZWF0ZXIgTWFuY2hlc3RlcjEQMA4GA1UEBxMHU2FsZm9yZDEaMBgG
A1UEChMRQ09NT0RPIENBIExpbWl0ZWQxPTA7BgNVBAMTNENPTU9ETyBSU0EgQ2xpZW50IEF1dGhl
bnRpY2F0aW9uIGFuZCBTZWN1cmUgRW1haWwgQ0EwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEK
AoIBAQC+s55XrCh2dUAWxzgDmNPGGHYhUPMleQtMtaDRfTpYPpynMS6n9jR22YRq2tA9NEjk6vW7
rN/5sYFLIP1of3l0NKZ6fLWfF2VgJ5cijKYy/qlAckY1wgOkUMgzKlWlVJGyK+UlNEQ1/5ErCsHq
9x9aU/x1KwTdF/LCrT03Rl/FwFrf1XTCwa2QZYL55AqLPikFlgqOtzk06kb2qvGlnHJvijjI03BO
rNpo+kZGpcHsgyO1/u1OZTaOo8wvEU17VVeP1cHWse9tGKTDyUGg2hJZjrqck39UIm/nKbpDSZ0J
sMoIw/JtOOg0JC56VzQgBo7ictReTQE5LFLG3yQK+xS1AgMBAAGjggE8MIIBODAfBgNVHSMEGDAW
gBS7r34CPfqm8TyEjq3uOJjs2TIy1DAdBgNVHQ4EFgQUgq9sjPjF/pZhfOgfPStxSF7Ei8AwDgYD
VR0PAQH/BAQDAgGGMBIGA1UdEwEB/wQIMAYBAf8CAQAwEQYDVR0gBAowCDAGBgRVHSAAMEwGA1Ud
HwRFMEMwQaA/oD2GO2h0dHA6Ly9jcmwuY29tb2RvY2EuY29tL0NPTU9ET1JTQUNlcnRpZmljYXRp
b25BdXRob3JpdHkuY3JsMHEGCCsGAQUFBwEBBGUwYzA7BggrBgEFBQcwAoYvaHR0cDovL2NydC5j
b21vZG9jYS5jb20vQ09NT0RPUlNBQWRkVHJ1c3RDQS5jcnQwJAYIKwYBBQUHMAGGGGh0dHA6Ly9v
Y3NwLmNvbW9kb2NhLmNvbTANBgkqhkiG9w0BAQwFAAOCAgEAeFyygSg0TzzuX1bOn5dW7I+iaxf2
8/ZJCAbU2C81zd9A/tNx4+jsQgwRGiHjZrAYayZrrm78hOx7aEpkfNPQIHGG6Fvq3EzWf/Lvx7/h
k6zSPwIal9v5IkDcZoFD7f3iT7PdkHJY9B51csvU50rxpEg1OyOT8fk2zvvPBuM4qQNqbGWlnhMp
IMwpWZT89RY0wpJO+2V6eXEGGHsROs3njeP9DqqqAJaBa4wBeKOdGCWn1/Jp2oY6dyNmNppI4ZNM
UH4Tam85S1j6E95u4+1Nuru84OrMIzqvISE2HN/56ebTOWlcrurffade2022O/tUU1gb4jfWCcyv
B8czm12FgX/y/lRjmDbEA08QJNB2729Y+io1IYO3ztveBdvUCIYZojTq/OCR6MvnzS6X72HP0PRL
RTiOSEmIDsS5N5w/8IW1Hva5hEFy6fDAfd9yI+O+IMMAj1KcL/Zo9jzJ16HO5m60ttl1Enk8MQkz
/W3JlHaeI5iKFn4UJu1/cP2YHXYPiWf2JyBzsLBrGk1II+3yL8aorYew6CQvdVifC3HtwlSam9V1
niiCfOBe2C12TdKGu05LWIA3ZkFcWJGaNXOZ6Ggyh/TqvXG5v7zmEVDNXFnHn9tFpMpOUvxhcsjy
cBtH0dZ0WrNw6gH+HF8TIhCnH3+zzWuDN0Rk6h9KVkfKehIwggXYMIIDwKADAgECAhBMqvnK22Nv
4B/3TthbA4adMA0GCSqGSIb3DQEBDAUAMIGFMQswCQYDVQQGEwJHQjEbMBkGA1UECBMSR3JlYXRl
ciBNYW5jaGVzdGVyMRAwDgYDVQQHEwdTYWxmb3JkMRowGAYDVQQKExFDT01PRE8gQ0EgTGltaXRl
ZDErMCkGA1UEAxMiQ09NT0RPIFJTQSBDZXJ0aWZpY2F0aW9uIEF1dGhvcml0eTAeFw0xMDAxMTkw
MDAwMDBaFw0zODAxMTgyMzU5NTlaMIGFMQswCQYDVQQGEwJHQjEbMBkGA1UECBMSR3JlYXRlciBN
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
AaOCAfMwggHvMB8GA1UdIwQYMBaAFIKvbIz4xf6WYXzoHz0rcUhexIvAMB0GA1UdDgQWBBRjn/GS
Juh8DKxLx8YgPKopKgyxBTAOBgNVHQ8BAf8EBAMCBaAwDAYDVR0TAQH/BAIwADAgBgNVHSUEGTAX
BggrBgEFBQcDBAYLKwYBBAGyMQEDBQIwEQYJYIZIAYb4QgEBBAQDAgUgMEYGA1UdIAQ/MD0wOwYM
KwYBBAGyMQECAQEBMCswKQYIKwYBBQUHAgEWHWh0dHBzOi8vc2VjdXJlLmNvbW9kby5uZXQvQ1BT
MFoGA1UdHwRTMFEwT6BNoEuGSWh0dHA6Ly9jcmwuY29tb2RvY2EuY29tL0NPTU9ET1JTQUNsaWVu
dEF1dGhlbnRpY2F0aW9uYW5kU2VjdXJlRW1haWxDQS5jcmwwgYsGCCsGAQUFBwEBBH8wfTBVBggr
BgEFBQcwAoZJaHR0cDovL2NydC5jb21vZG9jYS5jb20vQ09NT0RPUlNBQ2xpZW50QXV0aGVudGlj
YXRpb25hbmRTZWN1cmVFbWFpbENBLmNydDAkBggrBgEFBQcwAYYYaHR0cDovL29jc3AuY29tb2Rv
Y2EuY29tMCgGA1UdEQQhMB+BHXRvcnZhbGRzQGxpbnV4LWZvdW5kYXRpb24ub3JnMA0GCSqGSIb3
DQEBCwUAA4IBAQAGi1sxlNUFKWBzuBr+awa5Pl46M0AHRkFPiu3VKUkaNu8XuIA2i6Pj6rgiT/3l
7ca/KvxohOUvFTYnq6Fr26H6BJT6XaMiC6LItbfoIMB2yzFOVuruxfTUO7TCJPCg4oLEtUUIMS1v
KrajMYuEaI5rVAY04ntAa9nRnjj8TqDg+OXupr8yHrkomt7qWlsyZQKExtmQ4DvfEUADDY2ue6Kn
qNa5FHY8uBWlYBSaHnnR90Rr0Rqd4naFPQ1Kkkxp35g0tcdGBN5Qcyli834X9rdyhj9CwSwOSnCD
KYvaXyUP3o7hBubLcdMz/VM9VKT5HnU6c3rFemJSmUc41Htu57YYMYICsDCCAqwCAQEwga0wgZcx
CzAJBgNVBAYTAkdCMRswGQYDVQQIExJHcmVhdGVyIE1hbmNoZXN0ZXIxEDAOBgNVBAcTB1NhbGZv
cmQxGjAYBgNVBAoTEUNPTU9ETyBDQSBMaW1pdGVkMT0wOwYDVQQDEzRDT01PRE8gUlNBIENsaWVu
dCBBdXRoZW50aWNhdGlvbiBhbmQgU2VjdXJlIEVtYWlsIENBAhEAyRamH6VuTQrvgXSXzzbh6jAN
BglghkgBZQMEAgEFAKCB1DAvBgkqhkiG9w0BCQQxIgQg6aRHmxcTfO/qegGW06KdfmOG3Jd/B6Jj
ikU71PZIw3swGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEHATAcBgkqhkiG9w0BCQUxDxcNMTgxMjA3
MTg1MzA1WjBpBgkqhkiG9w0BCQ8xXDBaMAsGCWCGSAFlAwQBKjALBglghkgBZQMEARYwCwYJYIZI
AWUDBAECMAoGCCqGSIb3DQMHMAsGCSqGSIb3DQEBCjALBgkqhkiG9w0BAQcwCwYJYIZIAWUDBAIB
MA0GCSqGSIb3DQEBAQUABIIBAAcZ6br9XnHukmmwwxu0I02F8KDm7FGQGNPzTLxQn8DHcebl3iCx
sFvnriiJpNUb3yVxDRChivyN6LZIfG+YJleNXnUVARTNyiL66a8Vcqzyp7flz7D4qEwLJPnc+nYA
LAQsyuT6u0Lit7IRQMdW2s7l11MORknuFV64ywDPaQU9R8SzvLDJqMIc7PHjyli+m/tcM4Ls41Ev
IDf27BkB48oPXWlCEdnVVLCZRTQEFGBfjN7HkGefeEqERV5Dd5rguCNumupdXpLVjGeHVNPq4cih
3LGwPSA1cxrCWfvGTQGnQHb6wBnuq1VqEJZ8h8ALL7KOtc+7QA+O+M+j5G0CHNg=
--000000000000205adb057c7320d4--
