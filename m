Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751313AbeFAW2e (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 18:28:34 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:34388 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750964AbeFAW2c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 18:28:32 -0400
X-Google-Smtp-Source: ADUXVKLciJD1Apds9nMZDfb2r/E1EjOnIkhlr7Lf53yP8VJ1gIkzrlKigNUj5ln01qqJrjGqe/L3WuCEtM6t/iUXquk=
MIME-Version: 1.0
X-Originating-IP: [108.20.156.165]
In-Reply-To: <1527780226.3427.20.camel@linux.vnet.ibm.com>
References: <1527616920-5415-1-git-send-email-zohar@linux.vnet.ibm.com>
 <1527616920-5415-9-git-send-email-zohar@linux.vnet.ibm.com>
 <CAHC9VhQL+CsqKL83fSZhjEZVSjKKfmLULvehXZ8SZhtK5xzLMQ@mail.gmail.com>
 <1527635645.3534.39.camel@linux.vnet.ibm.com> <CAHC9VhQQX-JAnV-6jEOsug-6siyO9mrNa=rYK9Whg-MYcfHxgA@mail.gmail.com>
 <1527780226.3427.20.camel@linux.vnet.ibm.com>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 1 Jun 2018 18:28:30 -0400
Message-ID: <CAHC9VhSjeruk_EM3DZ0fu8aq8_qbhD9BtfhtJ0Ery8mOMu2wrw@mail.gmail.com>
Subject: Re: [PATCH v4a 8/8] module: replace the existing LSM hook in init_module
To: Mimi Zohar <zohar@linux.vnet.ibm.com>
Cc: Kees Cook <keescook@chromium.org>, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
        David Howells <dhowells@redhat.com>,
        "Luis R . Rodriguez" <mcgrof@kernel.org>,
        Eric Biederman <ebiederm@xmission.com>, kexec@lists.infradead.org,
        Andres Rodriguez <andresx7@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Jeff Vander Stoep <jeffv@google.com>,
        Casey Schaufler <casey@schaufler-ca.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 31, 2018 at 11:23 AM, Mimi Zohar <zohar@linux.vnet.ibm.com> wrote:
> Both the init_module and finit_module syscalls call either directly
> or indirectly the security_kernel_read_file LSM hook.  This patch
> replaces the direct call in init_module with a call to the new
> security_kernel_load_data hook and makes the corresponding changes
> in SELinux, LoadPin, and IMA.
>
> Signed-off-by: Mimi Zohar <zohar@linux.vnet.ibm.com>
> Cc: Jeff Vander Stoep <jeffv@google.com>
> Cc: Paul Moore <paul@paul-moore.com>
> Cc: Casey Schaufler <casey@schaufler-ca.com>
> Cc: Kees Cook <keescook@chromium.org>
>
> ---
> Changelog:
> - For SELinux, have both the security_kernel_read_file and
> security_kernel_load_data LSM hooks call selinux_kernel_read_file().
> - LoadPin: replace existing init_module LSM hook support with
> new security_kernel_load_data hook.
>
>  kernel/module.c                   |  2 +-
>  security/integrity/ima/ima_main.c | 24 ++++++++++--------------
>  security/loadpin/loadpin.c        | 15 +++++++++++++++
>  security/selinux/hooks.c          | 15 +++++++++++++++
>  4 files changed, 41 insertions(+), 15 deletions(-)

As mentioned in the previous iteration, I have no strong opinion on
the question of the LSM hooks, but the SELinux bits look okay to me.

Acked-by: Paul Moore <paul@paul-moore.com>

> diff --git a/kernel/module.c b/kernel/module.c
> index ce8066b88178..b97c642b5b4d 100644
> --- a/kernel/module.c
> +++ b/kernel/module.c
> @@ -2879,7 +2879,7 @@ static int copy_module_from_user(const void __user *umod, unsigned long len,
>         if (info->len < sizeof(*(info->hdr)))
>                 return -ENOEXEC;
>
> -       err = security_kernel_read_file(NULL, READING_MODULE);
> +       err = security_kernel_load_data(LOADING_MODULE);
>         if (err)
>                 return err;
>
> diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
> index 5a7696152982..cd33a2eff496 100644
> --- a/security/integrity/ima/ima_main.c
> +++ b/security/integrity/ima/ima_main.c
> @@ -438,17 +438,6 @@ static int read_idmap[READING_MAX_ID] = {
>   */
>  int ima_read_file(struct file *file, enum kernel_read_file_id read_id)
>  {
> -       bool sig_enforce = is_module_sig_enforced();
> -
> -       if (!file && read_id == READING_MODULE) {
> -               if (!sig_enforce && (ima_appraise & IMA_APPRAISE_MODULES) &&
> -                   (ima_appraise & IMA_APPRAISE_ENFORCE)) {
> -                       pr_err("impossible to appraise a module without a file descriptor. sig_enforce kernel parameter might help\n");
> -                       return -EACCES; /* INTEGRITY_UNKNOWN */
> -               }
> -               return 0;       /* We rely on module signature checking */
> -       }
> -
>         if (read_id == READING_FIRMWARE_PREALLOC_BUFFER) {
>                 if ((ima_appraise & IMA_APPRAISE_FIRMWARE) &&
>                     (ima_appraise & IMA_APPRAISE_ENFORCE)) {
> @@ -487,9 +476,6 @@ int ima_post_read_file(struct file *file, void *buf, loff_t size,
>                 return 0;
>         }
>
> -       if (!file && read_id == READING_MODULE) /* MODULE_SIG_FORCE enabled */
> -               return 0;
> -
>         /* permit signed certs */
>         if (!file && read_id == READING_X509_CERTIFICATE)
>                 return 0;
> @@ -518,6 +504,8 @@ int ima_post_read_file(struct file *file, void *buf, loff_t size,
>   */
>  int ima_load_data(enum kernel_load_data_id id)
>  {
> +       bool sig_enforce;
> +
>         if ((ima_appraise & IMA_APPRAISE_ENFORCE) != IMA_APPRAISE_ENFORCE)
>                 return 0;
>
> @@ -533,6 +521,14 @@ int ima_load_data(enum kernel_load_data_id id)
>                         pr_err("Prevent firmware sysfs fallback loading.\n");
>                         return -EACCES; /* INTEGRITY_UNKNOWN */
>                 }
> +               break;
> +       case LOADING_MODULE:
> +               sig_enforce = is_module_sig_enforced();
> +
> +               if (!sig_enforce && (ima_appraise & IMA_APPRAISE_MODULES)) {
> +                       pr_err("impossible to appraise a module without a file descriptor. sig_enforce kernel parameter might help\n");
> +                       return -EACCES; /* INTEGRITY_UNKNOWN */
> +               }
>         default:
>                 break;
>         }
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
paul moore
www.paul-moore.com
