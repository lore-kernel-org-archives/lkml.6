Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751220AbeECUkB (ORCPT <rfc822;w@1wt.eu>);
        Thu, 3 May 2018 16:40:01 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:53525 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750962AbeECUj7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 May 2018 16:39:59 -0400
X-Google-Smtp-Source: AB8JxZq7/Ugig/JFrBa9SM/e6QL1Dl5Ut8QHuOSj8n5RQHUV70G+ALzXzMGbZxvewaEzXaup3Hata8cHNMVpZ8W777I=
MIME-Version: 1.0
References: <1523572911-16363-1-git-send-email-zohar@linux.vnet.ibm.com> <87r2mso5up.fsf@xmission.com>
In-Reply-To: <87r2mso5up.fsf@xmission.com>
From: Matthew Garrett <mjg59@google.com>
Date: Thu, 03 May 2018 20:39:48 +0000
Message-ID: <CACdnJuukT4SYLcDwi7+ObqbCDS4ZEAMpgz57OL3_eSevW0QuVg@mail.gmail.com>
Subject: Re: [PATCH 0/3] kexec: limit kexec_load syscall
To: ebiederm@xmission.com
Cc: Mimi Zohar <zohar@linux.vnet.ibm.com>,
        David Howells <dhowells@redhat.com>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        kexec@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 3, 2018 at 1:13 PM Eric W. Biederman <ebiederm@xmission.com>
wrote:

> Mimi Zohar <zohar@linux.vnet.ibm.com> writes:

> > In environments that require the kexec kernel image to be signed,
prevent
> > using the kexec_load syscall.  In order for LSMs and IMA to
differentiate
> > between kexec_load and kexec_file_load syscalls, this patch set adds a
> > call to security_kernel_read_file() in kexec_load_check().

> Having thought about it some more this justification for these changes
> does not work.  The functionality of kexec_load is already root-only.
> So in environments that require the kernel image to be signed just don't
> use kexec_load.  Possibly even compile kexec_load out to save space
> because you will never need it.  You don't need a new security hook to
> do any of that.  Userspace is a very fine mechanism for being the
> instrument of policy.

> If you don't trust userspace that needs to be spelled out very clearly.
> You need to talk about what your threat models are.

kexec_load gives root arbitrary power to modify the running kernel image,
including the ability to disable enforcement of module signatures. Given
that it weakens other security mechanisms that are designed to prevent root
from disabling them, it makes sense to allow the imposition of an
equivalent restriction.
