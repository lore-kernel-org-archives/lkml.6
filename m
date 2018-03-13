Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752463AbeCMIxC (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 04:53:02 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:41869 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752152AbeCMIxA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 04:53:00 -0400
X-Google-Smtp-Source: AG47ELuIxzsai0dx7mgTZ+9TRM+3yHPMUNAxtZHTs8OedYltwqKKaN3GdL8hXaLOenjeW4T9lQvmDg==
Subject: Re: hwmon/sch5627: Use common error handling code in sch5627_probe()
To: SF Markus Elfring <elfring@users.sourceforge.net>,
        linux-hwmon@vger.kernel.org
Cc: =?UTF-8?B?R8O8bnRlciBSw7Zjaw==?= <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>, LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>
References: <d08248a2-46d8-6f73-81f4-84ad21b7e640@users.sourceforge.net>
 <0cc0ab31-550b-fa34-aaa5-164f6ae7f7a9@redhat.com>
 <17810b74-7b72-074e-5fef-b614fcfed738@users.sourceforge.net>
From: Hans de Goede <hdegoede@redhat.com>
Message-ID: <e8a45f50-b625-ccb5-88cc-b888f57d1ca1@redhat.com>
Date: Tue, 13 Mar 2018 09:52:57 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <17810b74-7b72-074e-5fef-b614fcfed738@users.sourceforge.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 13-03-18 09:25, SF Markus Elfring wrote:
>>> Adjust jump targets so that a bit of exception handling can be better
>>> reused at the end of this function.
> …
>> goto-s going to a label calling another goto is completely unreadable.
> 
> I got an other software development view.
> 
> 
>> I really do not see any reason for the proposed changes,
> 
> I suggest to look once more.
> 
> 
>> they may remove a small amount of code duplication,
> 
> This was my software design goal in this case.

The diffstat of your patch is:

  1 file changed, 29 insertions(+), 31 deletions(-)

So you are asking people to review 60 changed lines to save 2,
that alone should be the point where you stop yourself from
*even* sending this patch. Review time is not an endless free
resource and this patch is wasting it for very little gain.

I see in the kernel git log that you've e.g. also send a lot
of patches removing pr_err / dev_err calls from memory
allocation failures. Those are good patches to have, they are
easy to review and significantly shrink the compiled kernel
size because of all the text strings you are removing.

This patch however will likely result in a binary which is
hardly smaller at all (if at all, the compiler does common
code elimination itself) while it is a complex patch to
review so comes with a large review cost.

Next time before you send a patch please carefully think if the
saving is worth the combination of reviewers time + the risk of
regressions (and keep in mind that both the reviewers time and
the risk of regressions cost increase for more complex changes).

>> but at a hugh cost wrt readability.
> 
> I proposed a different trade-off here.

<sigh> not this again. Cleanup patches are appreciated, but there
always is a cost to making changes to perfectly working good code.

You've had this same discussion with Jonathan Cameron, the IIO
subsys maintainer at the end of 2017, it would be nice if you
were to actually listen to what people are saying about this.

As for this specific discussion, there are certain "design-patterns"
in the kernel, goto style error handling is one of them, the pattern
there ALWAYS is:

error_cleanup4:
	cleanup4();
	/* fall through to next cleanup */
error_cleanup3:
	cleanup3();
	/* fall through to next cleanup */
error_cleanup2:
	cleanup2();
	/* fall through to next cleanup */
error_cleanup1:
	cleanup1();
	/* fall through to next cleanup */
	return error;

Notice the fall-thoughs those are ALWAYS there, never, ever is
there a goto after a cleanup label. The idea is that resources
are allocated in the order of resource1 (cleaned by cleanup1())
then resource2, etc. and the goto + fallthrough will cleanup
all resources which have been allocated at the time of the goto
in *reverse* order of allocation. The whole point of this design-
pattern to be able to a) do partial cleanup if we fail halfway
through; b) do it in reverse order. Your patches black goto magic
completely messes this up and clearly falls under the CS101
rule: never use goto.

Your proposed changes break how every experienced kernel developer
is expecting the code to be / work, causing your proposed changes
to have a HUGE cost wrt maintainability and readability, which
means the trade-off you're suggesting is anything but worth-while.

TL;DR: still NACK.

Regards,

Hans
