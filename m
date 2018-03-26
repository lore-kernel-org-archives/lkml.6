Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752792AbeCZRxj (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Mar 2018 13:53:39 -0400
Received: from mga01.intel.com ([192.55.52.88]:10398 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752622AbeCZRxi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Mar 2018 13:53:38 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,365,1517904000";
   d="scan'208";a="38268001"
Subject: Re: [PATCH 1/9] x86, pkeys: do not special case protection key 0
To: Shuah Khan <shuah@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        linux-kernel@vger.kernel.org
References: <20180326172721.D5B2CBB4@viggo.jf.intel.com>
 <20180326172722.8CC08307@viggo.jf.intel.com>
 <9c2de5f6-d9e2-3647-7aa8-86102e9fa6c3@kernel.org>
Cc: linux-mm@kvack.org, stable@kernel.org, linuxram@us.ibm.com,
        tglx@linutronix.de, mpe@ellerman.id.au, mingo@kernel.org,
        akpm@linux-foundation.org, Shuah Khan <shuahkh@osg.samsung.com>
From: Dave Hansen <dave.hansen@intel.com>
Message-ID: <b54257c2-138c-7ac9-8176-0dc4868093ef@intel.com>
Date: Mon, 26 Mar 2018 10:53:35 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <9c2de5f6-d9e2-3647-7aa8-86102e9fa6c3@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/26/2018 10:47 AM, Shuah Khan wrote:
> 
> Also what happens "pkey_free() pkey-0" - can you elaborate more on that
> "silliness consequences"

It's just what happens if you free any other pkey that is in use: it
might get reallocated later.  The most likely scenario is that you will
get pkey-0 back from pkey_alloc(), you will set an access-disable or
write-disable bit in PKRU for it, and your next stack access will SIGSEGV.
