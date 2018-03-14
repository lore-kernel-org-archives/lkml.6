Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751714AbeCNXqL (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 19:46:11 -0400
Received: from vps-vb.mhejs.net ([37.28.154.113]:52806 "EHLO vps-vb.mhejs.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751348AbeCNXqJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 19:46:09 -0400
Subject: Re: [PATCH v3 3/9] x86/microcode/AMD: install_equiv_cpu_table()
 should not return (signed) int
To: Borislav Petkov <bp@alien8.de>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
References: <cover.1520973389.git.mail@maciej.szmigiero.name>
 <cf57ed15-df47-087e-c98f-527e4ce1e0f8@maciej.szmigiero.name>
 <20180314175824.GG16605@pd.tnic>
From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Message-ID: <b913d9fd-9722-d5cc-cf94-426885947890@maciej.szmigiero.name>
Date: Thu, 15 Mar 2018 00:46:05 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180314175824.GG16605@pd.tnic>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14.03.2018 18:58, Borislav Petkov wrote:
> On Tue, Mar 13, 2018 at 10:06:34PM +0100, Maciej S. Szmigiero wrote:
>> The maximum possible value returned by install_equiv_cpu_table() is
>> UINT_MAX + CONTAINER_HDR_SZ (on a 64-bit kernel).
>> This is more than (signed) int type currently returned by this function can
>> hold so this function will need to return a size_t instead.
> 
> I'm trying to parse this but I'm not really sure.
> 
> All I know is:
> 
> 	unsigned int size = ibuf[2];
> 
> and that is really a 4-byte unsigned quantity so anything less is an
> arbitrary limitation.

There is no limit on CPU equivalence table length in this patch series
like it was in the previous version.

The maximum possible value returned by install_equiv_cpu_table() of
UINT_MAX + CONTAINER_HDR_SZ comes from the maximum value of this 'size'
variable (that is UINT_MAX) plus the header length of CONTAINER_HDR_SZ.
This won't fit in 'int' type, hence this patch.

That's because this functions tells its caller how much bytes to skip
from the beginning of a microcode container file to the first patch
section contained in it.

Maciej
