Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752834AbeCMSjL convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 14:39:11 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:42672 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752000AbeCMSjJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 14:39:09 -0400
Subject: Re: [PATCH v4 4/6] ipc: Clamp msgmni and shmmni to the real IPCMNI
 limit
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: "Luis R. Rodriguez" <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>
References: <1520885744-1546-1-git-send-email-longman@redhat.com>
 <1520885744-1546-5-git-send-email-longman@redhat.com>
 <87woyfyh57.fsf@xmission.com>
From: Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <5d4a858a-3136-5ef4-76fe-a61e7f2aed56@redhat.com>
Date: Tue, 13 Mar 2018 14:39:07 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <87woyfyh57.fsf@xmission.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/13/2018 02:17 PM, Eric W. Biederman wrote:
> Waiman Long <longman@redhat.com> writes:
>
>> A user can write arbitrary integer values to msgmni and shmmni sysctl
>> parameters without getting error, but the actual limit is really
>> IPCMNI (32k). This can mislead users as they think they can get a
>> value that is not real.
>>
>> Enforcing the limit by failing the sysctl parameter write, however,
>> can break existing user applications.
> Which applications examples please.
>
> I am seeing this patchset late but it looks like a whole lot of changes
> to avoid a theoretical possibility.
>
> Changes that have an impact on more than just the ipc code you are
> patching.
>
> That makes me feel very uncomfortable with these changes.
>
> Eric

This patchset is constructed to address a customer request that there is
no easy way to find out the actual usable range of a sysctl parameter.
In this particular case, the customer wants to use more than 32k shared
memory segments. They can put in a large value into shmmni, but the
application didn't work properly because shmmni was internally clamped
to 32k without any visible sign that a smaller limit has been imposed.

Out of a concern that there might be customers out there setting those
sysctl parameters outside of the allowable range without knowing it,
just enforcing the right limits may have the undesirable consequence of
breaking their existing setup scripts. I don't have concrete example of
what customers are doing that, but it  won't look good if we wait until
the complaints come in.

The new code won't affect existing code unless the necessary flag is
set. So would you mind elaborating what other impact do you see that
will affect other non-IPC code in an undesirable way?

Cheers,
Longman
