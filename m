Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CBA6C07E85
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 20:46:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF81F20868
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 20:46:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Vd/9QNK6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF81F20868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726196AbeLGUqz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 15:46:55 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:40729 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726008AbeLGUqy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 15:46:54 -0500
Received: by mail-lf1-f65.google.com with SMTP id v5so3975030lfe.7
        for <linux-kernel@vger.kernel.org>; Fri, 07 Dec 2018 12:46:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tWyHpQTBZKriuLAc8wFQEbzKA2GMmblMdpVyIpJdUIo=;
        b=Vd/9QNK6D0+iBds8RYbFbLVgC+sV9SV4GL8u+zSBScrhc3aowJPxsGV/6zMGuEnsja
         lKBd1fuCKZCezINckhCYTdi41RVBRu+fSmAaY3oC64YokkOSanGAueW/XkO4uUjRcqQa
         /jH0NtxHd9tYbehVktP8Agsh4ZR7qAo37I/uw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tWyHpQTBZKriuLAc8wFQEbzKA2GMmblMdpVyIpJdUIo=;
        b=KSmiH8cioceIk2dchNR8gBW8Ki3++ZIBuHim5fLP+2qiDNwJN+sMggUp06ID1aL8As
         LHzJRqO8fL3bsk9ZwRZYeBlwdH+ugeJNlbLFRt6k3bGX/7nbt2bPRh+6UsiAj1h7qqAX
         CWuXyv4KXzY4zzoJVVca9Yay5e9vGBmMC92jY+t1YyL9WRM5s94iGUx4n15xmrO4jTVR
         UpGPgI+G3yxlP+inKWi07uExkug52ztbYob9F6hE84EIt9FORWvyi0iA+vmhGedq5K0Y
         YAwbDGjZV24xwuehlsoZlG0+dzHQa9LV8DDGRiXnH7lbyJUT8U/tSgfAZ7TRaNBSo7b8
         bwfA==
X-Gm-Message-State: AA+aEWaW2/ysCVpFG6FGk1QwJHl/E1HDWeFWlQPWf3QcNRJyuBOTTX/j
        My70cM3J0c1LfA7UezoyL4feThX+Bck=
X-Google-Smtp-Source: AFSGD/XVreDH3lwuHJeSoJXeIr6oCIo1vcwxUhSvRyvCj/tCAM4fF9WiHEId6K7FbUKVd/m+rVawjA==
X-Received: by 2002:a19:7306:: with SMTP id o6mr2143041lfc.136.1544215611512;
        Fri, 07 Dec 2018 12:46:51 -0800 (PST)
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com. [209.85.208.172])
        by smtp.gmail.com with ESMTPSA id f8sm859336lfe.72.2018.12.07.12.46.47
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Dec 2018 12:46:48 -0800 (PST)
Received: by mail-lj1-f172.google.com with SMTP id k19-v6so4635251lji.11
        for <linux-kernel@vger.kernel.org>; Fri, 07 Dec 2018 12:46:47 -0800 (PST)
X-Received: by 2002:a2e:3e04:: with SMTP id l4-v6mr2114900lja.148.1544215607344;
 Fri, 07 Dec 2018 12:46:47 -0800 (PST)
MIME-Version: 1.0
References: <20181207184423.1962-1-sean.j.christopherson@intel.com> <20181207195223.23968-1-sean.j.christopherson@intel.com>
In-Reply-To: <20181207195223.23968-1-sean.j.christopherson@intel.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 7 Dec 2018 12:46:30 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgtN9nQBimLuOmBxY8eYqDRhNeBOW_uvnhqtZSFycyHuA@mail.gmail.com>
Message-ID: <CAHk-=wgtN9nQBimLuOmBxY8eYqDRhNeBOW_uvnhqtZSFycyHuA@mail.gmail.com>
Subject: Re: [PATCH v2] x86/fault: Decode and print #PF oops in human readable form
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
        boundary="000000000000be593c057c74b642"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--000000000000be593c057c74b642
Content-Type: text/plain; charset="UTF-8"

On Fri, Dec 7, 2018 at 11:52 AM Sean Christopherson
<sean.j.christopherson@intel.com> wrote:
>
> Remove the per-bit decoding of the error code and instead print:

The patch looks fine to me, so feel free to add an acked-by, but:

 (a) I'm not the one who wanted the human-legible version in the first
place, since I'm also perfectly ok with just the error code, so my
judgement is obviously garbage wrt this whole thing

 (b) it would be good to have a couple of actual examples of the
printout to judge.

I can certainly imagine how it looks just from the patch, but maybe if
I actually see reality I'd go "eww". Or somebody else goes "eww".

              Linus

--000000000000be593c057c74b642
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
BglghkgBZQMEAgEFAKCB1DAvBgkqhkiG9w0BCQQxIgQgEbNMBjcZOTIxHx31jyh7+zm1asg/Jon+
WFOhIwPoA0swGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEHATAcBgkqhkiG9w0BCQUxDxcNMTgxMjA3
MjA0NjQ3WjBpBgkqhkiG9w0BCQ8xXDBaMAsGCWCGSAFlAwQBKjALBglghkgBZQMEARYwCwYJYIZI
AWUDBAECMAoGCCqGSIb3DQMHMAsGCSqGSIb3DQEBCjALBgkqhkiG9w0BAQcwCwYJYIZIAWUDBAIB
MA0GCSqGSIb3DQEBAQUABIIBADVdNa2c+lpbtqokAnVVb9yVXPSwj3jjqNtpFXxpmT4Dz3cIFLmH
LjPZzY/vB01YwEZmafB8YZPMyZeDpm4wKZVMuZo+/W2y03KkroiVGUEAISLgEe/HLxAoqDb/KWGQ
6sZsXYWcqYNGuUC00aQlawF1yfbs6+QEhBfQBiskakw3AC9vUjPfdBOjTuFPICpN/AJWP0y8gg5G
BTZxAPWg2uxoQNGDIOw3qe277snGmnwuOh+X9yXGBygAVfFFAVLxO7g9jmxwaqFFlmj9O/+WO7P7
sHy8lHWs+nOURMCu/Vy+MmL1AKXYvsy8+54yqDGn75dObbM7TtlvlFvR1RPAhs0=
--000000000000be593c057c74b642--
