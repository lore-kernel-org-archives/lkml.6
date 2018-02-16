Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756842AbeBPAph (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Feb 2018 19:45:37 -0500
Received: from ppsw-40.csi.cam.ac.uk ([131.111.8.140]:39076 "EHLO
        ppsw-40.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756813AbeBPApf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Feb 2018 19:45:35 -0500
X-Cam-AntiVirus: no malware found
X-Cam-ScannerInfo: http://help.uis.cam.ac.uk/email-scanner-virus
Subject: Re: [PATCH RFC v2 0/6] x86: Disabling PTI in compatibility mode
To: Nadav Amit <nadav.amit@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>
Cc: Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, Willy Tarreau <w@1wt.eu>,
        x86@kernel.org, linux-kernel@vger.kernel.org
References: <20180215163602.61162-1-namit@vmware.com>
 <27a0082c-fadb-792a-740e-70932d51f1b5@linux.intel.com>
 <91CEEFA7-86C8-4731-BC7E-6AF5CC3A1BA4@gmail.com>
From: Andrew Cooper <andrew.cooper3@citrix.com>
Message-ID: <f0fc93ca-ba1d-2570-5d79-0c02ee388f9d@citrix.com>
Date: Fri, 16 Feb 2018 00:45:35 +0000
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <91CEEFA7-86C8-4731-BC7E-6AF5CC3A1BA4@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/02/2018 00:25, Nadav Amit wrote:
> Dave Hansen <dave.hansen@linux.intel.com> wrote:
>
>> On 02/15/2018 08:35 AM, Nadav Amit wrote:
>>> I removed the PTI disabling while SMEP is unsupported, although I
>>> must admit I did not fully understand why it is required.
>> Do you mean you don't fully understand how PTI gives SMEP-like behavior
>> on non-SMEP hardware?
> No. I understand how it provide SMEP-like behavior, and I understand the value
> of SMEP by itself.
>
> However, I do not understand why SMEP-like protection is required to protect
> processes that run in compatibility-mode from Meltdown/Spectre attacks. As
> far as I understand, the process should not be able to manipulate the kernel
> to execute code in the low 4GB.

Being 32bit is itself sufficient protection against Meltdown (as long as
there nothing interesting of the kernels mapped below the 4G boundary).

However, a 32bit compatibility process try to attack with Spectre/SP2 to
redirect speculation back into userspace, at which point (if successful)
the pipeline will be speculating in 64bit mode, and Meltdown is back on
the table.  SMEP will block this attack vector, irrespective of other
SP2 defences the kernel may employ, but a fully SP2-defended kernel
doesn't require SMEP to be safe in this case.

~Andrew
