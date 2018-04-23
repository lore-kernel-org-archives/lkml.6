Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932210AbeDWREc (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 13:04:32 -0400
Received: from sonic316-19.consmr.mail.bf2.yahoo.com ([74.6.130.193]:44071
        "EHLO sonic316-19.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932129AbeDWRE2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 13:04:28 -0400
X-YMail-OSG: wYXbXiQVM1nvDuu1aB.L7oeT7zipbGNQWi29vGUJi4Zf_9W2WTCbsoyKKufmtVQ
 hzwvQWuShbHyCn0NCRPAlIiEZ9ysMZxsWN8PhBv1TlmGZPkC4X_dfZzQrNVYKNm39e.JFVg7MNwM
 6Do8gboDdM0wwHRnZK8l5CdRF.mItmsUW6EYwy2eOSG8fGkY7EWKZ0ATUI.mmMsY9nLaPlaAym44
 I1oXYUSxypds9brLMdzlPne6McFLQQ0mObpJ_Zx1Ez1nDZnkexA_EwbLj0sD3r8gS2HLyo6FPvr.
 CAztrc14vfWek.KZd_bUl62kdHK2vnQld9Tb_d9zMfWQK2BnjAec1wKuzAdh5O4Olw3Z7w80juPn
 tG1LFhzqbCb2EDsw92vpoop82Tlvj35d93IdqTykpXqx1FJ2vZ4l3eM4mJHF41MBohIghQdfZHkl
 SUUzNJrELwpkGtmT6V4.Ez2mc8DNPlzBbix4b4BAnk7aVJlID.nkS883CMSUL5.T3dPmtxc2ats7
 Wmt1W7b_uYHywNiGPt4yk_ckaTGgVQkG3R8mXRcQWGftaILnZgM2b89KWUb5cG7p5FUmW3NYRrvz
 YvkI-
Subject: Re: [PATCH 0/3] Introduce LSM-hook for socketpair(2)
To: David Herrmann <dh.herrmann@gmail.com>, linux-kernel@vger.kernel.org
Cc: James Morris <jmorris@namei.org>, Paul Moore <paul@paul-moore.com>,
        teg@jklm.no, Stephen Smalley <sds@tycho.nsa.gov>,
        selinux@tycho.nsa.gov, linux-security-module@vger.kernel.org,
        Eric Paris <eparis@parisplace.org>, serge@hallyn.com,
        davem@davemloft.net, netdev@vger.kernel.org,
        Casey Schaufler <casey@schaufler-ca.com>
References: <20180423133015.5455-1-dh.herrmann@gmail.com>
From: Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <32eea1d6-450c-bc68-59d6-74bc5011ead2@schaufler-ca.com>
Date: Mon, 23 Apr 2018 10:04:19 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180423133015.5455-1-dh.herrmann@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/23/2018 6:30 AM, David Herrmann wrote:
> Hi
>
> This series adds a new LSM hook for the socketpair(2) syscall. The idea
> is to allow SO_PEERSEC to be called on AF_UNIX sockets created via
> socketpair(2), and return the same information as if you emulated
> socketpair(2) via a temporary listener socket. Right now SO_PEERSEC
> will return the unlabeled credentials for a socketpair, rather than the
> actual credentials of the creating process.
>
> ...
>
> This series only adds SELinux backends, since that is what we need for
> RHEL. I will gladly extend the other LSMs if needed.

I would be very happy to see a proposed patch for Smack. It shouldn't
be much different from the SELinux version, with the exception that it
will use pointers to smk_known structures instead of secids. It would be
a big help, as someone just threw a whole new species of scorpion into
this pit.

>
> Thanks
> David
>
> [1] https://github.com/bus1/dbus-broker/blob/master/src/util/test-peersec.c
> [2] https://www.spinics.net/lists/selinux/msg22674.html
>
> David Herrmann (3):
>   security: add hook for socketpair(AF_UNIX, ...)
>   net/unix: hook unix_socketpair() into LSM
>   selinux: provide unix_stream_socketpair callback
>
>  include/linux/lsm_hooks.h |  8 ++++++++
>  include/linux/security.h  |  7 +++++++
>  net/unix/af_unix.c        |  5 +++++
>  security/security.c       |  6 ++++++
>  security/selinux/hooks.c  | 14 ++++++++++++++
>  5 files changed, 40 insertions(+)
>
