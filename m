Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751823AbeEVRwD (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 13:52:03 -0400
Received: from shards.monkeyblade.net ([184.105.139.130]:45368 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751443AbeEVRwB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 13:52:01 -0400
Date: Tue, 22 May 2018 13:52:00 -0400 (EDT)
Message-Id: <20180522.135200.1524557376650201204.davem@davemloft.net>
To: wang6495@umn.edu
Cc: kjlu@umn.edu, mac@melware.de, isdn@linux-pingi.de,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] isdn: eicon: fix a missing-check bug
From: David Miller <davem@davemloft.net>
In-Reply-To: <1526885887-9759-1-git-send-email-wang6495@umn.edu>
References: <1526885887-9759-1-git-send-email-wang6495@umn.edu>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wenwen Wang <wang6495@umn.edu>
Date: Mon, 21 May 2018 01:58:07 -0500

> In divasmain.c, the function divas_write() firstly invokes the function
> diva_xdi_open_adapter() to open the adapter that matches with the adapter
> number provided by the user, and then invokes the function diva_xdi_write()
> to perform the write operation using the matched adapter. The two functions
> diva_xdi_open_adapter() and diva_xdi_write() are located in diva.c.
> 
> In diva_xdi_open_adapter(), the user command is copied to the object 'msg'
> from the userspace pointer 'src' through the function pointer 'cp_fn',
> which eventually calls copy_from_user() to do the copy. Then, the adapter
> number 'msg.adapter' is used to find out a matched adapter from the
> 'adapter_queue'. A matched adapter will be returned if it is found.
> Otherwise, NULL is returned to indicate the failure of the verification on
> the adapter number.
> 
> As mentioned above, if a matched adapter is returned, the function
> diva_xdi_write() is invoked to perform the write operation. In this
> function, the user command is copied once again from the userspace pointer
> 'src', which is the same as the 'src' pointer in diva_xdi_open_adapter() as
> both of them are from the 'buf' pointer in divas_write(). Similarly, the
> copy is achieved through the function pointer 'cp_fn', which finally calls
> copy_from_user(). After the successful copy, the corresponding command
> processing handler of the matched adapter is invoked to perform the write
> operation.
> 
> It is obvious that there are two copies here from userspace, one is in
> diva_xdi_open_adapter(), and one is in diva_xdi_write(). Plus, both of
> these two copies share the same source userspace pointer, i.e., the 'buf'
> pointer in divas_write(). Given that a malicious userspace process can race
> to change the content pointed by the 'buf' pointer, this can pose potential
> security issues. For example, in the first copy, the user provides a valid
> adapter number to pass the verification process and a valid adapter can be
> found. Then the user can modify the adapter number to an invalid number.
> This way, the user can bypass the verification process of the adapter
> number and inject inconsistent data.
> 
> This patch reuses the data copied in
> diva_xdi_open_adapter() and passes it to diva_xdi_write(). This way, the
> above issues can be avoided.
> 
> Signed-off-by: Wenwen Wang <wang6495@umn.edu>

Applied and queued up for -stable.
