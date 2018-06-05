Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752172AbeFETpN (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 15:45:13 -0400
Received: from mail-ua0-f196.google.com ([209.85.217.196]:35046 "EHLO
        mail-ua0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752003AbeFETpL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 15:45:11 -0400
X-Google-Smtp-Source: ADUXVKIhclEpN1DR9olT68VaRXtwJTIqPFuW/eerJ1minDoU3Kyp4/FWB9WQw1c+/E7CTodpDBfbdadDun1TuhJrNwg=
MIME-Version: 1.0
In-Reply-To: <1527780226.3427.20.camel@linux.vnet.ibm.com>
References: <1527616920-5415-1-git-send-email-zohar@linux.vnet.ibm.com>
 <1527616920-5415-9-git-send-email-zohar@linux.vnet.ibm.com>
 <CAHC9VhQL+CsqKL83fSZhjEZVSjKKfmLULvehXZ8SZhtK5xzLMQ@mail.gmail.com>
 <1527635645.3534.39.camel@linux.vnet.ibm.com> <CAHC9VhQQX-JAnV-6jEOsug-6siyO9mrNa=rYK9Whg-MYcfHxgA@mail.gmail.com>
 <1527780226.3427.20.camel@linux.vnet.ibm.com>
From: Kees Cook <keescook@chromium.org>
Date: Tue, 5 Jun 2018 12:45:09 -0700
X-Google-Sender-Auth: F7EPIyD9kmVJ8zXou41kMNyWJLY
Message-ID: <CAGXu5jLXSEWHorm6=h9+1cP-y8ZX2_ALcra6g9x7Tm-O0kU3DQ@mail.gmail.com>
Subject: Re: [PATCH v4a 8/8] module: replace the existing LSM hook in init_module
To: Mimi Zohar <zohar@linux.vnet.ibm.com>
Cc: Paul Moore <paul@paul-moore.com>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        "Luis R . Rodriguez" <mcgrof@kernel.org>,
        Eric Biederman <ebiederm@xmission.com>,
        Kexec Mailing List <kexec@lists.infradead.org>,
        Andres Rodriguez <andresx7@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Jeff Vander Stoep <jeffv@google.com>,
        Casey Schaufler <casey@schaufler-ca.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 31, 2018 at 8:23 AM, Mimi Zohar <zohar@linux.vnet.ibm.com> wrote:
> diff --git a/security/loadpin/loadpin.c b/security/loadpin/loadpin.c
> index 5fa191252c8f..a9c07bfbc338 100644
> --- a/security/loadpin/loadpin.c
> +++ b/security/loadpin/loadpin.c
> @@ -173,9 +173,24 @@ static int loadpin_read_file(struct file *file, enum kernel_read_file_id id)
>         return 0;
>  }
>
> +static int loadpin_load_data(enum kernel_load_data_id id)
> +{
> +       int rc = 0;
> +
> +       switch (id) {
> +       case LOADING_MODULE:
> +               rc = loadpin_read_file(NULL, READING_MODULE);
> +       default:
> +               break;
> +       }
> +
> +       return rc;
> +}

Is it worth keeping the same enum between the two hooks? That would
simplify this a bit since it could just pass the id without remapping.

And if you must have a separate enum, please change this to fail
closed instead of open (and mark the fall-through):

int rc = -EPERM;

switch (id) {
case LOADING_MODULE:
    rc = loadpin_read_file(NULL, READING_MODULE);
    /* Fall-through */
default:
    break;
}

Thanks!

-Kees

> +
>  static struct security_hook_list loadpin_hooks[] __lsm_ro_after_init = {
>         LSM_HOOK_INIT(sb_free_security, loadpin_sb_free_security),
>         LSM_HOOK_INIT(kernel_read_file, loadpin_read_file),
> +       LSM_HOOK_INIT(kernel_load_data, loadpin_load_data),
>  };
>
>  void __init loadpin_add_hooks(void)
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 02ebd1585eaf..475aed9ee2c7 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -4059,6 +4059,20 @@ static int selinux_kernel_read_file(struct file *file,
>         return rc;
>  }
>
> +static int selinux_kernel_load_data(enum kernel_load_data_id id)
> +{
> +       int rc = 0;
> +
> +       switch (id) {
> +       case LOADING_MODULE:
> +               rc = selinux_kernel_module_from_file(NULL);
> +       default:
> +               break;
> +       }
> +
> +       return rc;
> +}
> +
>  static int selinux_task_setpgid(struct task_struct *p, pid_t pgid)
>  {
>         return avc_has_perm(&selinux_state,
> @@ -6950,6 +6964,7 @@ static struct security_hook_list selinux_hooks[] __lsm_ro_after_init = {
>         LSM_HOOK_INIT(kernel_act_as, selinux_kernel_act_as),
>         LSM_HOOK_INIT(kernel_create_files_as, selinux_kernel_create_files_as),
>         LSM_HOOK_INIT(kernel_module_request, selinux_kernel_module_request),
> +       LSM_HOOK_INIT(kernel_load_data, selinux_kernel_load_data),
>         LSM_HOOK_INIT(kernel_read_file, selinux_kernel_read_file),
>         LSM_HOOK_INIT(task_setpgid, selinux_task_setpgid),
>         LSM_HOOK_INIT(task_getpgid, selinux_task_getpgid),
> --
> 2.7.5
>



-- 
Kees Cook
Pixel Security
