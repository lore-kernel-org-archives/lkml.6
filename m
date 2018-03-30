Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751392AbeC3KjM (ORCPT <rfc822;w@1wt.eu>);
        Fri, 30 Mar 2018 06:39:12 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:55724 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751195AbeC3KjJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Mar 2018 06:39:09 -0400
X-Google-Smtp-Source: AIpwx49dRfIKKvD5gMkBjA2IAqiq+G6JlpST5d+osDjJ/xjijIlkXYUDR9+e3G8PqzLzDfAZF6y+3A==
Date: Fri, 30 Mar 2018 12:39:07 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Rahul Lakkireddy <rahul.lakkireddy@chelsio.com>
Cc: netdev@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
        davem@davemloft.net, viro@zeniv.linux.org.uk, ebiederm@xmission.com,
        stephen@networkplumber.org, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, ganeshgr@chelsio.com,
        nirranjan@chelsio.com, indranil@chelsio.com
Subject: Re: [PATCH net-next v2 1/2] fs/crashdd: add API to collect hardware
 dump in second kernel
Message-ID: <20180330103907.GC3313@nanopsycho>
References: <cover.1521888444.git.rahul.lakkireddy@chelsio.com>
 <296ffbd47fd4f30238689e636bd2480683224227.1521888444.git.rahul.lakkireddy@chelsio.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <296ffbd47fd4f30238689e636bd2480683224227.1521888444.git.rahul.lakkireddy@chelsio.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sat, Mar 24, 2018 at 11:56:33AM CET, rahul.lakkireddy@chelsio.com wrote:
>Add a new module crashdd that exports the /sys/kernel/crashdd/
>directory in second kernel, containing collected hardware/firmware
>dumps.
>
>The sequence of actions done by device drivers to append their device
>specific hardware/firmware logs to /sys/kernel/crashdd/ directory are
>as follows:
>
>1. During probe (before hardware is initialized), device drivers
>register to the crashdd module (via crashdd_add_dump()), with
>callback function, along with buffer size and log name needed for
>firmware/hardware log collection.
>
>2. Crashdd creates a driver's directory under
>/sys/kernel/crashdd/<driver>. Then, it allocates the buffer with

This smells. I need to identify the exact ASIC instance that produced
the dump. To identify by driver name does not help me if I have multiple
instances of the same driver. This looks wrong to me. This looks like
a job for devlink where you have 1 devlink instance per 1 ASIC instance.

Please see:
http://patchwork.ozlabs.org/project/netdev/list/?series=36524

I bevieve that the solution in the patchset could be used for
your usecase too.


>requested size and invokes the device driver's registered callback
>function.
>
>3. Device driver collects all hardware/firmware logs into the buffer
>and returns control back to crashdd.
>
>4. Crashdd exposes the buffer as a binary file via
>/sys/kernel/crashdd/<driver>/<dump_file>.
>
