Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751624AbeCOANL (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 20:13:11 -0400
Received: from vps-vb.mhejs.net ([37.28.154.113]:44384 "EHLO vps-vb.mhejs.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751131AbeCOANJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 20:13:09 -0400
Subject: Re: [PATCH v3 3/9] x86/microcode/AMD: install_equiv_cpu_table()
 should not return (signed) int
To: Borislav Petkov <bp@alien8.de>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
References: <cover.1520973389.git.mail@maciej.szmigiero.name>
 <cf57ed15-df47-087e-c98f-527e4ce1e0f8@maciej.szmigiero.name>
 <20180314175824.GG16605@pd.tnic>
 <b913d9fd-9722-d5cc-cf94-426885947890@maciej.szmigiero.name>
 <20180314235812.GB11061@pd.tnic>
From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Message-ID: <21fe4521-0fc7-c5ed-5a2a-4c7e93097385@maciej.szmigiero.name>
Date: Thu, 15 Mar 2018 01:13:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180314235812.GB11061@pd.tnic>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15.03.2018 00:58, Borislav Petkov wrote:
> On Thu, Mar 15, 2018 at 12:46:05AM +0100, Maciej S. Szmigiero wrote:
>> The maximum possible value returned by install_equiv_cpu_table() of
>> UINT_MAX + CONTAINER_HDR_SZ comes from the maximum value of this 'size'
>> variable (that is UINT_MAX) plus the header length of CONTAINER_HDR_SZ.
>> This won't fit in 'int' type, hence this patch.
> 
> So make it fit by returning an unsigned int.
> 

This can be done if this function is modified to return only the CPU
equivalence table length (without the container header length), leaving
its single caller the job of adding the container header length to skip
to the fist patch section.

Otherwise we introduce a equivalence table length limit of
UINT_MAX - CONTAINER_HDR_SZ, as anything more will overflow an
unsigned int variable on a 64-bit kernel (on 32-bit this will be caught
by the equivalence table truncation check).

Maciej
