Return-Path: <SRS0=OQvN=N5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38419C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Nov 2018 14:10:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CE9220815
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Nov 2018 14:10:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6CE9220815
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=dei.uc.pt
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727343AbeKSAam (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 18 Nov 2018 19:30:42 -0500
Received: from smtp.dei.uc.pt ([193.137.203.253]:54376 "EHLO smtp.dei.uc.pt"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726180AbeKSAam (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Nov 2018 19:30:42 -0500
X-Greylist: delayed 305 seconds by postgrey-1.27 at vger.kernel.org; Sun, 18 Nov 2018 19:30:39 EST
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
        (user=sneves mech=PLAIN bits=0)
        by smtp.dei.uc.pt (8.15.2/8.15.2) with ESMTPSA id wAIE3vS4007701
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL)
        for <linux-kernel@vger.kernel.org>; Sun, 18 Nov 2018 14:04:02 GMT
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp.dei.uc.pt wAIE3vS4007701
Received: by mail-ed1-f54.google.com with SMTP id x30so18495035edx.2
        for <linux-kernel@vger.kernel.org>; Sun, 18 Nov 2018 06:04:02 -0800 (PST)
X-Gm-Message-State: AGRZ1gLI7zkcy8rxYi9Pr4ScDFYOabENM46/vc08CSTS9ZTckFKlv+4e
        cJXmEPRh+1jvGbo1CslmxTen+bzhZ4AwXIzab0U=
X-Google-Smtp-Source: AJdET5fMZ4rTHY1FcJbPU9PQzU3P6tSCG+ujbzfoO/y+ZdtU5YbzQ1HtOe8VmCN0rM9mk2KlZ+ZGySLo/bcxN2Rs5j8=
X-Received: by 2002:a17:906:1a49:: with SMTP id j9-v6mr14203181ejf.45.1542549837007;
 Sun, 18 Nov 2018 06:03:57 -0800 (PST)
MIME-Version: 1.0
From:   Samuel Neves <sneves@dei.uc.pt>
Date:   Sun, 18 Nov 2018 14:03:20 +0000
X-Gmail-Original-Message-ID: <CAEX_ruH=9VHD-8YH2--4mYPq7LD2Ciya2ADeSO=c38s2KaQhUg@mail.gmail.com>
Message-ID: <CAEX_ruH=9VHD-8YH2--4mYPq7LD2Ciya2ADeSO=c38s2KaQhUg@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] x86/fpu: track AVX-512 usage of tasks
To:     aubrey.li@linux.intel.com, dave.hansen@intel.com,
        aubrey.li@intel.com, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, peterz@infradead.org,
        "H. Peter Anvin" <hpa@zytor.com>
Cc:     ak@linux.intel.com, tim.c.chen@linux.intel.com,
        arjan@linux.intel.com, linux-kernel@vger.kernel.org
Content-Type: multipart/mixed; boundary="00000000000015e591057af0df23"
X-FCTUC-DEI-SIC-MailScanner-Information: Please contact helpdesk@dei.uc.pt for more information
X-FCTUC-DEI-SIC-MailScanner-ID: wAIE3vS4007701
X-FCTUC-DEI-SIC-MailScanner: Found to be clean
X-FCTUC-DEI-SIC-MailScanner-SpamCheck: not spam, SpamAssassin (cached,
        score=-60.1, required 3.252, autolearn=not spam, ALL_TRUSTED -10.00,
        BAYES_00 -0.10, L_SMTP_AUTH -50.00)
X-FCTUC-DEI-SIC-MailScanner-From: sneves@dei.uc.pt
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--00000000000015e591057af0df23
Content-Type: text/plain; charset="UTF-8"

On 11/17/18 12:36 AM, Li, Aubrey wrote:
> On 2018/11/17 7:10, Dave Hansen wrote:
>> Just to be clear: there are 3 AVX-512 XSAVE states:
>>
>>          XFEATURE_OPMASK,
>>          XFEATURE_ZMM_Hi256,
>>          XFEATURE_Hi16_ZMM,
>>
>> I honestly don't know what XFEATURE_OPMASK does.  It does not appear to
>> be affected by VZEROUPPER (although VZEROUPPER's SDM documentation isn't
>> looking too great).

XFEATURE_OPMASK refers to the additional 8 mask registers used in
AVX512. These are more similar to general purpose registers than
vector registers, and should not be too relevant here.

>>
>> But, XFEATURE_ZMM_Hi256 is used for the upper 256 bits of the
>> registers ZMM0-ZMM15.  Those are AVX-512-only registers.  The only way
>> to get data into XFEATURE_ZMM_Hi256 state is by using AVX512 instructions.
>>
>> XFEATURE_Hi16_ZMM is the same.  The only way to get state in there is
>> with AVX512 instructions.
>>
>> So, first of all, I think you *MUST* check XFEATURE_ZMM_Hi256 and
>> XFEATURE_Hi16_ZMM.  That's without question.
>
> No, XFEATURE_ZMM_Hi256 does not request turbo license 2, so it's less
> interested to us.
>

I think Dave is right, and it's easy enough to check this. See the
attached program. For the "high current" instruction vpmuludq
operating on zmm0--zmm3 registers, we have (on a Skylake-SP Xeon Gold
5120)

           175,097      core_power.lvl0_turbo_license:u
                     ( +-  2.18% )
            41,185      core_power.lvl1_turbo_license:u
                     ( +-  1.55% )
        83,928,648      core_power.lvl2_turbo_license:u
                     ( +-  0.00% )

while for the same code operating on zmm28--zmm31 registers, we have

           163,507      core_power.lvl0_turbo_license:u
                     ( +-  6.85% )
            47,390      core_power.lvl1_turbo_license:u
                     ( +- 12.25% )
        83,927,735      core_power.lvl2_turbo_license:u
                     ( +-  0.00% )

In other words, the register index does not seem to matter at all for
turbo license purposes (this makes sense, considering these chips have
168 vector registers internally; zmm15--zmm31 are simply newly exposed
architectural registers).

We can also see that XFEATURE_Hi16_ZMM does not imply license 1 or 2;
we may be using xmm15--xmm31 purely for the convenient extra register
space. For example, cases 4 and 5 of the sample program:

        84,064,239      core_power.lvl0_turbo_license:u
                     ( +-  0.00% )
                 0      core_power.lvl1_turbo_license:u
                 0      core_power.lvl2_turbo_license:u

        84,060,625      core_power.lvl0_turbo_license:u
                     ( +-  0.00% )
                 0      core_power.lvl1_turbo_license:u
                 0      core_power.lvl2_turbo_license:u

So what's most important is the width of the vectors being used, not
the instruction set or the register index. Second to that is the
instruction type, namely whether those are "heavy" instructions.
Neither of these things can be accurately captured by the XSAVE state.

>>
>> It's probably *possible* to run AVX512 instructions by loading state
>> into the YMM register and then executing AVX512 instructions that only
>> write to memory and never to register state.  That *might* allow
>> XFEATURE_Hi16_ZMM and XFEATURE_ZMM_Hi256 to stay in the init state, but
>> for the frequency to be affected since AVX512 instructions _are_
>> executing.  But, there's no way to detect this situation from XSAVE
>> states themselves.
>>
>
> Andi should have more details on this. FWICT, not all AVX512 instructions
> has high current, those only touching memory do not cause notable frequency
> drop.

According to section 15.26 of the Intel optimization reference manual,
"heavy" instructions consist of floating-point and integer
multiplication. Moves, adds, logical operations, etc, will request at
most turbo license 1 when operating on zmm registers.

>
> Thanks,
> -Aubrey
>

--00000000000015e591057af0df23
Content-Type: text/x-csrc; charset="US-ASCII"; name="turbo.c"
Content-Disposition: attachment; filename="turbo.c"
Content-Transfer-Encoding: base64
Content-ID: <f_jomy6sz30>
X-Attachment-Id: f_jomy6sz30

I2luY2x1ZGUgPHN0ZGxpYi5oPgoKI2RlZmluZSBJTlNOX0xPT1BfTE8oaW5zbiwgcmVnKSBkbyB7
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBcCiAgYXNtIHZvbGF0aWxlKCAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgXAogICAg
Im1vdiAkMTw8MjQsJSVyY3g7IiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIFwKICAgICIuYWxpZ24gMzI7IiAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICBcCiAgICAiMToiICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgXAogICAgI2luc24gIiAi
ICIlJSIgI3JlZyAiMCIgIiwiICIlJSIgI3JlZyAiMCIgIiwiICIlJSIgI3JlZyAiMCIgIjsiICAg
IFwKICAgICNpbnNuICIgIiAiJSUiICNyZWcgIjEiICIsIiAiJSUiICNyZWcgIjEiICIsIiAiJSUi
ICNyZWcgIjEiICI7IiAgICBcCiAgICAjaW5zbiAiICIgIiUlIiAjcmVnICIyIiAiLCIgIiUlIiAj
cmVnICIyIiAiLCIgIiUlIiAjcmVnICIyIiAiOyIgICAgXAogICAgI2luc24gIiAiICIlJSIgI3Jl
ZyAiMyIgIiwiICIlJSIgI3JlZyAiMyIgIiwiICIlJSIgI3JlZyAiMyIgIjsiICAgIFwKICAgICJk
ZWMgJSVyY3g7IiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICBcCiAgICAiam56IDFiOyIgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgXAogICAgOjo6ICJyY3giICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIFwKICApOyAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBc
Cn0gd2hpbGUoMCk7CgojZGVmaW5lIElOU05fTE9PUF9ISShpbnNuLCByZWcpIGRvIHsgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIFwKICBhc20gdm9sYXRpbGUoICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBcCiAgICAibW92ICQx
PDwyNCwlJXJjeDsiICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgXAogICAgIi5hbGlnbiAzMjsiICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIFwKICAgICIxOiIgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBcCiAgICAjaW5zbiAiICIgIiUlIiAj
cmVnICIzMSIgIiwiICIlJSIgI3JlZyAiMzEiICIsIiAiJSUiICNyZWcgIjMxIiAiOyIgXAogICAg
I2luc24gIiAiICIlJSIgI3JlZyAiMzAiICIsIiAiJSUiICNyZWcgIjMwIiAiLCIgIiUlIiAjcmVn
ICIzMCIgIjsiIFwKICAgICNpbnNuICIgIiAiJSUiICNyZWcgIjI5IiAiLCIgIiUlIiAjcmVnICIy
OSIgIiwiICIlJSIgI3JlZyAiMjkiICI7IiBcCiAgICAjaW5zbiAiICIgIiUlIiAjcmVnICIyOCIg
IiwiICIlJSIgI3JlZyAiMjgiICIsIiAiJSUiICNyZWcgIjI4IiAiOyIgXAogICAgImRlYyAlJXJj
eDsiICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IFwKICAgICJqbnogMWI7IiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICBcCiAgICA6OjogInJjeCIgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgXAogICk7ICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIFwKfSB3aGls
ZSgwKTsKCgoKaW50IG1haW4oaW50IGFyZ2MsIGNoYXIgKiogYXJndikgewogIGludCB4ID0gc3Ry
dG91bChhcmd2WzFdLCAwLCAxMCk7CiAgYXNtIHZvbGF0aWxlKCJ2emVyb2FsbCIpOwogIHN3aXRj
aCh4KSB7CiAgY2FzZSAwOgogICAgSU5TTl9MT09QX0xPKHZwbXVsdWRxLCB6bW0pOwogICAgYnJl
YWs7CiAgY2FzZSAxOgogICAgSU5TTl9MT09QX0hJKHZwbXVsdWRxLCB6bW0pOwogICAgYnJlYWs7
CiAgY2FzZSAyOgogICAgSU5TTl9MT09QX0xPKHZwbXVsdWRxLCB5bW0pOwogICAgYnJlYWs7CiAg
Y2FzZSAzOgogICAgSU5TTl9MT09QX0hJKHZwbXVsdWRxLCB5bW0pOwogICAgYnJlYWs7CiAgY2Fz
ZSA0OgogICAgSU5TTl9MT09QX0xPKHZwbXVsdWRxLCB4bW0pOwogICAgYnJlYWs7CiAgY2FzZSA1
OgogICAgSU5TTl9MT09QX0hJKHZwbXVsdWRxLCB4bW0pOwogICAgYnJlYWs7CiAgY2FzZSA2Ogog
ICAgSU5TTl9MT09QX0xPKHZwYWRkcSwgem1tKTsKICAgIGJyZWFrOwogIGNhc2UgNzoKICAgIElO
U05fTE9PUF9ISSh2cGFkZHEsIHptbSk7CiAgICBicmVhazsKICBjYXNlIDg6CiAgICBJTlNOX0xP
T1BfTE8odnBhZGRxLCB5bW0pOwogICAgYnJlYWs7CiAgY2FzZSA5OgogICAgSU5TTl9MT09QX0hJ
KHZwYWRkcSwgeW1tKTsKICAgIGJyZWFrOwogIGNhc2UgMTA6CiAgICBJTlNOX0xPT1BfTE8odnBh
ZGRxLCB4bW0pOwogICAgYnJlYWs7CiAgY2FzZSAxMToKICAgIElOU05fTE9PUF9ISSh2cGFkZHEs
IHhtbSk7CiAgICBicmVhazsKICB9CiAgcmV0dXJuIDA7Cn0KCg==
--00000000000015e591057af0df23--
