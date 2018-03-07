Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934195AbeCGRkp (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 12:40:45 -0500
Received: from sonic313-17.consmr.mail.ne1.yahoo.com ([66.163.185.40]:45922
        "EHLO sonic313-17.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933415AbeCGRkj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 12:40:39 -0500
X-YMail-OSG: ncix7ZgVM1k2kJkZoZ2dRwXkMXGPLU93GxTy7LsA8zpvElMfYjQGAhNhaRuGjUc
 Rqu0ISb_OjStKw0YysB.7b85MfmSDyQlX5YG5ElOYSIXR3d5ntj4yTYnr1cTqkiSNiv7jlOQ8nts
 Cyp19tMVmgwh9klONz0XWEBNNIKfA.pSovJL90AgMazEavi1jftQwShAfg2tKwHctmzTUlL4XrhM
 v7UrM.AfVfFPPxJYulVWIdO.RGA7Qx43_oZvGFX_2D.ABxmXTJu.7k.6EcWjZTOgVbM6w.HZTnPt
 ka5Yk.LD56Rwwa8e70wHSFzQhdtnheg2R0uDlkD4zT6g3whADMJoOLMOl8r.hNRdPQG9MocHVjBz
 7bjqu0lz2YQOoVf7o7HTaOwJUF3iV2RzXgBgjLtbPsdkPMspfK0vdkKK3smqqW8k9mUbIGLmWcBq
 62hXuEwDJ8A4mPA0fEKPF_yMrJyr9OSl_R7CpJjWPvPdhOKCNTJY3p2tsMNYfd4wBXXyMHfGj5zZ
 5kKZugXC.udP7.PdLB1VeL7PFKNbmdRNh5OH5F1QGkSYOsfg-
Subject: Re: [PATCH v4 0/3] Safe, dynamically loadable LSM hooks
To: Sargun Dhillon <sargun@sargun.me>,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: penguin-kernel@i-love.sakura.ne.jp, keescook@chromium.org,
        igor.stoppa@huawei.com
References: <cover.1520407240.git.sargun@sargun.me>
From: Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <d2b31866-def9-dd2a-766c-b55ebbff9f8a@schaufler-ca.com>
Date: Wed, 7 Mar 2018 09:40:31 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <cover.1520407240.git.sargun@sargun.me>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/6/2018 11:22 PM, Sargun Dhillon wrote:
> This patchset introduces safe dynamic LSM support. These are currently
> not unloadable, until we figure out a use case that needs that. Adding
> an unload hook is trivial given the way the patch is written.

If I recall correctly (it's been a decade since the discussion)
one of the reasons for not having loadable security modules was
that no one had a good idea on how they might be unloaded safely.
I'm not 100% convinced that there are no cases where you might
want to load a module that you can't unload, but I can definitely
come up with scenarios where it could be harmful.

> This exposes a second mechanism of loading hooks which are in modules.
> These hooks are behind static keys, so they should come at low performance
> overhead. The built-in hook heads are read-only, whereas the dynamic hooks
> are mutable.

I don't like having two mechanisms and I really don't like the
way you replace the structure of hooks with an array of pointers.

> Not all hooks can be loaded into. Some hooks are blacklisted, and therefore
> trying to load a module which plugs into those hooks will fail.

Which hooks, and why?

> One of the big benefits with loadable security modules is to help with
> "unknown unknowns". Although, livepatch is excellent, sometimes, a
> surgical LSM is simpler.

I could buy this if you could unload the module when the surgery
is done. As it is, you are stuck with whatever restrictions you
have introduced forever.

> It includes an example LSM that prevents specific time travel.
>
> Changes since v3:
>   * readded hook blacklisted
>   * return error, rather than panic if unable to allocate memory
>
> Changes since v2:
>   * inode get/set security is readded
>   * xfrm singleton hook readded
>   * Security hooks are turned into an array
>   * Security hooks and dynamic hooks enum is collapsed
>
> Changes since v1:
>   * It no longer allows unloading of modules
>   * prctl is fixed
>   * inode get/set security is removed
>   * xfrm singleton hook removed
>
>
> Sargun Dhillon (3):
>   security: Refactor LSM hooks into an array and enum
>   security: Expose a mechanism to load lsm hooks dynamically at runtime
>   security: Add an example sample dynamic LSM
>
>  include/linux/lsm_hooks.h | 459 ++++++++++++++++++++++++----------------------
>  samples/Kconfig           |   6 +
>  samples/Makefile          |   2 +-
>  samples/lsm/Makefile      |   4 +
>  samples/lsm/lsm_example.c |  33 ++++
>  security/Kconfig          |   9 +
>  security/inode.c          |  13 +-
>  security/security.c       | 222 ++++++++++++++++++++--
>  8 files changed, 508 insertions(+), 240 deletions(-)
>  create mode 100644 samples/lsm/Makefile
>  create mode 100644 samples/lsm/lsm_example.c
>
