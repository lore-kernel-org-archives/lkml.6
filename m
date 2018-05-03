Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751239AbeECXSP (ORCPT <rfc822;w@1wt.eu>);
        Thu, 3 May 2018 19:18:15 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:58380 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750911AbeECXSO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 May 2018 19:18:14 -0400
From: Steve Grubb <sgrubb@redhat.com>
To: Tyler Hicks <tyhicks@canonical.com>
Cc: Paul Moore <paul@paul-moore.com>, linux-kernel@vger.kernel.org,
        Kees Cook <keescook@chromium.org>,
        Andy Lutomirski <luto@amacapital.net>, Will Drewry <wad@chromium.org>,
        Eric Paris <eparis@redhat.com>, Jonathan Corbet <corbet@lwn.net>,
        linux-audit@redhat.com, linux-security-module@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH v2 3/4] seccomp: Audit attempts to modify the actions_logged sysctl
Date: Thu, 03 May 2018 19:18:12 -0400
Message-ID: <4867923.cYbF5sH2MZ@x2>
Organization: Red Hat
In-Reply-To: <e23b61ec-9400-4c40-cdb1-92d224f05967@canonical.com>
References: <1525276400-7161-1-git-send-email-tyhicks@canonical.com> <2397134.HQDQRr6h1X@x2> <e23b61ec-9400-4c40-cdb1-92d224f05967@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, May 3, 2018 6:36:18 PM EDT Tyler Hicks wrote:
> On 05/03/2018 04:12 PM, Steve Grubb wrote:
> > On Thursday, May 3, 2018 4:51:36 PM EDT Tyler Hicks wrote:
> >> On 05/03/2018 03:48 PM, Paul Moore wrote:
> >>> On Thu, May 3, 2018 at 4:42 PM, Steve Grubb <sgrubb@redhat.com> wrote:
> >>>> On Thursday, May 3, 2018 4:18:26 PM EDT Paul Moore wrote:
> >>>>> On Wed, May 2, 2018 at 2:18 PM, Steve Grubb <sgrubb@redhat.com> 
wrote:
> >>>>>> On Wednesday, May 2, 2018 11:53:19 AM EDT Tyler Hicks wrote:
> >>>>>>> The decision to log a seccomp action will always be subject to the
> >>>>>>> value of the kernel.seccomp.actions_logged sysctl, even for
> >>>>>>> processes
> >>>>>>> that are being inspected via the audit subsystem, in an upcoming
> >>>>>>> patch.
> >>>>>>> Therefore, we need to emit an audit record on attempts at writing
> >>>>>>> to
> >>>>>>> the
> >>>>>>> actions_logged sysctl when auditing is enabled.
> >>>>>>> 
> >>>>>>> This patch updates the write handler for the actions_logged sysctl
> >>>>>>> to
> >>>>>>> emit an audit record on attempts to write to the sysctl. Successful
> >>>>>>> writes to the sysctl will result in a record that includes a
> >>>>>>> normalized
> >>>>>>> list of logged actions in the "actions" field and a "res" field
> >>>>>>> equal
> >>>>>>> to
> >>>>>>> 0. Unsuccessful writes to the sysctl will result in a record that
> >>>>>>> doesn't include the "actions" field and has a "res" field equal to
> >>>>>>> 1.
> >>>>>>> 
> >>>>>>> Not all unsuccessful writes to the sysctl are audited. For example,
> >>>>>>> an
> >>>>>>> audit record will not be emitted if an unprivileged process
> >>>>>>> attempts
> >>>>>>> to
> >>>>>>> open the sysctl file for reading since that access control check is
> >>>>>>> not
> >>>>>>> part of the sysctl's write handler.
> >>>>>>> 
> >>>>>>> Below are some example audit records when writing various strings
> >>>>>>> to
> >>>>>>> the
> >>>>>>> actions_logged sysctl.
> >>>>>>> 
> >>>>>>> Writing "not-a-real-action", when the kernel.seccomp.actions_logged
> >>>>>>> sysctl previously was "kill_process kill_thread trap errno trace
> >>>>>>> log",
> >>>>>>> 
> >>>>>>> emits this audit record:
> >>>>>>>  type=CONFIG_CHANGE msg=audit(1525275273.537:130):
> >>>>>>>  op=seccomp-logging
> >>>>>>>  old-actions=kill_process,kill_thread,trap,errno,trace,log res=0
> >>>>>>> 
> >>>>>>> If you then write "kill_process kill_thread errno trace log", this
> >>>>>>> audit
> >>>>>>> 
> >>>>>>> record is emitted:
> >>>>>>>  type=CONFIG_CHANGE msg=audit(1525275310.208:136):
> >>>>>>>  op=seccomp-logging
> >>>>>>>  actions=kill_process,kill_thread,errno,trace,log
> >>>>>>>  old-actions=kill_process,kill_thread,trap,errno,trace,log res=1
> >>>>>>> 
> >>>>>>> If you then write the string "log log errno trace kill_process
> >>>>>>> kill_thread", which is unordered and contains the log action twice,
> >>>>>>> 
> >>>>>>> it results in the same actions value as the previous record:
> >>>>>>>  type=CONFIG_CHANGE msg=audit(1525275325.613:142):
> >>>>>>>  op=seccomp-logging
> >>>>>>>  actions=kill_process,kill_thread,errno,trace,log
> >>>>>>>  old-actions=kill_process,kill_thread,errno,trace,log res=1
> >>>>>>> 
> >>>>>>> No audit records are generated when reading the actions_logged
> >>>>>>> sysctl.
> >>>>>> 
> >>>>>> ACK for the format of the records.
> >>>>> 
> >>>>> I just wanted to clarify the record format with you Steve ... the
> >>>>> "actions" and "old-actions" fields may not be included in the record
> >>>>> in cases where there is an error building the action value string,
> >>>>> are
> >>>>> you okay with that or would you prefer the fields to always be
> >>>>> included but with a "?" for the value?
> >>>> 
> >>>> A ? would be more in line with how other things are handled.
> >>> 
> >>> That's what I thought.
> >>> 
> >>> Would you mind putting together a v3 Tyler? :)
> >> 
> >> To be clear, "?" is only to be used when the call to
> >> seccomp_names_from_actions_logged() fails, right?
> > 
> > Yes and that is a question mark with no quotes in the audit record.
> > 
> >> If the sysctl write fails for some other reason, such as when an invalid
> >> action name is specified, can you confirm that you still want *no*
> >> "actions" field,
> > 
> > Its best that fields do not disappear. In the case of invalid input, you
> > can just leave the new value as ? so that nothing malicious can be
> > injected into the logs
> > 
> >> the "old-actions" field to be the value prior to attempting the update
> >> to the sysctl, and res to be 0?
> > 
> > Yes
> 
> I came up with one more question after hitting a corner case while testing.
> 
> It is valid to write an empty string to the sysctl. If the sysctl was
> set to "errno" and then later set to "", you'd see this with the current
> revision:
> 
>  type=CONFIG_CHANGE msg=audit(1525385824.643:173): op=seccomp-logging
>  actions= old-actions=errno res=1
> 
> Is that what you want or should the value of the "actions" field be
> something be something like this:
> 
>  actions=(none)

This ^^^ would be preferred. However, the parenthesis is not needed.

Thanks,
-Steve
