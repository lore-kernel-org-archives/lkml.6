Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752289AbeERHbe convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 03:31:34 -0400
Received: from prv1-mh.provo.novell.com ([137.65.248.33]:33652 "EHLO
        prv1-mh.provo.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751644AbeERHbd (ORCPT
        <rfc822;groupwise-linux-kernel@vger.kernel.org:4:1>);
        Fri, 18 May 2018 03:31:33 -0400
Message-Id: <5AFE815402000078001C3E50@prv1-mh.provo.novell.com>
X-Mailer: Novell GroupWise Internet Agent 18.0.0 
Date: Fri, 18 May 2018 01:31:32 -0600
From: "Jan Beulich" <JBeulich@suse.com>
To: "Boris Ostrovsky" <boris.ostrovsky@oracle.com>
Cc: "xen-devel" <xen-devel@lists.xenproject.org>,
        "Juergen Gross" <jgross@suse.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 1/2] xen/PVH: Set up GS segment for stack canary
References: <20180517144723.21585-1-boris.ostrovsky@oracle.com>
 <20180517144723.21585-2-boris.ostrovsky@oracle.com>
 <5AFD999402000078001C3B29@prv1-mh.provo.novell.com>
 <656c5250-3406-a98a-309c-ac3d7e3e4c41@oracle.com>
In-Reply-To: <656c5250-3406-a98a-309c-ac3d7e3e4c41@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>>> On 17.05.18 at 19:47, <boris.ostrovsky@oracle.com> wrote:
> On 05/17/2018 11:02 AM, Jan Beulich wrote:
>>>>> On 17.05.18 at 16:47, <boris.ostrovsky@oracle.com> wrote:
>>> @@ -64,6 +67,9 @@ ENTRY(pvh_start_xen)
>>>  	mov %eax,%es
>>>  	mov %eax,%ss
>>>  
>>> +	mov $PVH_CANARY_SEL,%eax
>>> +	mov %eax,%gs
>> I doubt this is needed for 64-bit (you could equally well load zero or leave
>> in place what's there in that case),
> 
> I don't understand this.

The actual selector value doesn't matter on 64-bit. Hence you could
omit the load altogether, or you could use plain zero. No need for the
(non-zero) selector, or (by implication) the GDT descriptor.

>>  and loading the selector before setting
>> the base address in the descriptor won't have the intended effect.
> 
> 
> I wasn't sure about this either but then I noticed that
> secondary_startup_64() does it in the same order (although not using the
> MSR).

Well, for one they load a null selector, which is independent of setting up
any GDT descriptors. I also don't understand why you say "although not
using the MSR" when they clearly do. And then, as said above (and also
in a comment in secondary_startup_64()), the actual selector value (and
when / if at all it is loaded) doesn't matter on 64-bit. The ordering does
matter on 32-bit though.

Jan
