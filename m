Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752825AbeEORnB (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 13:43:01 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:39999 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752178AbeEORmx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 13:42:53 -0400
X-Google-Smtp-Source: AB8JxZp30nN02iP5bbFuVhxff6pgY2YlqbmcoKqQWxsXEPjg/RSKA2QaWCKm0Z0F7R/pJzKWa9VSTk2HbCrxiYFs0NA=
MIME-Version: 1.0
In-Reply-To: <20180514225052.GA39419@beast>
References: <20180514225052.GA39419@beast>
From: Deepa Dinamani <deepa.kernel@gmail.com>
Date: Tue, 15 May 2018 10:42:52 -0700
Message-ID: <CABeXuvotW=hwDB4O4k_to031zbXxrbSLO0-AkBUP02s8Hb6h8Q@mail.gmail.com>
Subject: Re: [PATCH v2] pstore: Convert internal records to timespec64
To: Kees Cook <keescook@chromium.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Anton Vorontsov <anton@enomsg.org>, Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Acked-by: Deepa Dinamani <deepa.kernel@gmail.com>

I think for 4.18, I can include it as part of my series.

Thanks,
-Deepa

On Mon, May 14, 2018 at 3:50 PM, Kees Cook <keescook@chromium.org> wrote:
> This prepares pstore for converting the VFS layer to timespec64.
>
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
> I can carry this for v4.18 unless you'd like to do it as part of your series?
> ---
>  drivers/firmware/efi/efi-pstore.c | 27 ++++++++++++++-------------
>  fs/pstore/inode.c                 |  3 ++-
>  fs/pstore/platform.c              |  2 +-
>  fs/pstore/ram.c                   | 21 ++++++++++++++-------
>  include/linux/pstore.h            |  2 +-
>  5 files changed, 32 insertions(+), 23 deletions(-)
>
> diff --git a/drivers/firmware/efi/efi-pstore.c b/drivers/firmware/efi/efi-pstore.c
> index 5a0fa939d70f..cfe87b465819 100644
> --- a/drivers/firmware/efi/efi-pstore.c
> +++ b/drivers/firmware/efi/efi-pstore.c
> @@ -28,10 +28,9 @@ static int efi_pstore_close(struct pstore_info *psi)
>         return 0;
>  }
>
> -static inline u64 generic_id(unsigned long timestamp,
> -                            unsigned int part, int count)
> +static inline u64 generic_id(u64 timestamp, unsigned int part, int count)
>  {
> -       return ((u64) timestamp * 100 + part) * 1000 + count;
> +       return (timestamp * 100 + part) * 1000 + count;
>  }
>
>  static int efi_pstore_read_func(struct efivar_entry *entry,
> @@ -42,7 +41,8 @@ static int efi_pstore_read_func(struct efivar_entry *entry,
>         int i;
>         int cnt;
>         unsigned int part;
> -       unsigned long time, size;
> +       unsigned long size;
> +       u64 time;
>
>         if (efi_guidcmp(entry->var.VendorGuid, vendor))
>                 return 0;
> @@ -50,7 +50,7 @@ static int efi_pstore_read_func(struct efivar_entry *entry,
>         for (i = 0; i < DUMP_NAME_LEN; i++)
>                 name[i] = entry->var.VariableName[i];
>
> -       if (sscanf(name, "dump-type%u-%u-%d-%lu-%c",
> +       if (sscanf(name, "dump-type%u-%u-%d-%llu-%c",
>                    &record->type, &part, &cnt, &time, &data_type) == 5) {
>                 record->id = generic_id(time, part, cnt);
>                 record->part = part;
> @@ -62,7 +62,7 @@ static int efi_pstore_read_func(struct efivar_entry *entry,
>                 else
>                         record->compressed = false;
>                 record->ecc_notice_size = 0;
> -       } else if (sscanf(name, "dump-type%u-%u-%d-%lu",
> +       } else if (sscanf(name, "dump-type%u-%u-%d-%llu",
>                    &record->type, &part, &cnt, &time) == 4) {
>                 record->id = generic_id(time, part, cnt);
>                 record->part = part;
> @@ -71,7 +71,7 @@ static int efi_pstore_read_func(struct efivar_entry *entry,
>                 record->time.tv_nsec = 0;
>                 record->compressed = false;
>                 record->ecc_notice_size = 0;
> -       } else if (sscanf(name, "dump-type%u-%u-%lu",
> +       } else if (sscanf(name, "dump-type%u-%u-%llu",
>                           &record->type, &part, &time) == 3) {
>                 /*
>                  * Check if an old format,
> @@ -250,9 +250,10 @@ static int efi_pstore_write(struct pstore_record *record)
>         /* Since we copy the entire length of name, make sure it is wiped. */
>         memset(name, 0, sizeof(name));
>
> -       snprintf(name, sizeof(name), "dump-type%u-%u-%d-%lu-%c",
> +       snprintf(name, sizeof(name), "dump-type%u-%u-%d-%lld-%c",
>                  record->type, record->part, record->count,
> -                record->time.tv_sec, record->compressed ? 'C' : 'D');
> +                (long long)record->time.tv_sec,
> +                record->compressed ? 'C' : 'D');
>
>         for (i = 0; i < DUMP_NAME_LEN; i++)
>                 efi_name[i] = name[i];
> @@ -327,15 +328,15 @@ static int efi_pstore_erase(struct pstore_record *record)
>         char name[DUMP_NAME_LEN];
>         int ret;
>
> -       snprintf(name, sizeof(name), "dump-type%u-%u-%d-%lu",
> +       snprintf(name, sizeof(name), "dump-type%u-%u-%d-%lld",
>                  record->type, record->part, record->count,
> -                record->time.tv_sec);
> +                (long long)record->time.tv_sec);
>         ret = efi_pstore_erase_name(name);
>         if (ret != -ENOENT)
>                 return ret;
>
> -       snprintf(name, sizeof(name), "dump-type%u-%u-%lu",
> -               record->type, record->part, record->time.tv_sec);
> +       snprintf(name, sizeof(name), "dump-type%u-%u-%lld",
> +               record->type, record->part, (long long)record->time.tv_sec);
>         ret = efi_pstore_erase_name(name);
>
>         return ret;
> diff --git a/fs/pstore/inode.c b/fs/pstore/inode.c
> index 5fcb845b9fec..75afe5eb0574 100644
> --- a/fs/pstore/inode.c
> +++ b/fs/pstore/inode.c
> @@ -392,7 +392,8 @@ int pstore_mkfile(struct dentry *root, struct pstore_record *record)
>         inode->i_private = private;
>
>         if (record->time.tv_sec)
> -               inode->i_mtime = inode->i_ctime = record->time;
> +               inode->i_mtime = inode->i_ctime =
> +                       timespec64_to_timespec(record->time);
>
>         d_add(dentry, inode);
>
> diff --git a/fs/pstore/platform.c b/fs/pstore/platform.c
> index dc720573fd53..c238ab8ba31d 100644
> --- a/fs/pstore/platform.c
> +++ b/fs/pstore/platform.c
> @@ -328,7 +328,7 @@ void pstore_record_init(struct pstore_record *record,
>         record->psi = psinfo;
>
>         /* Report zeroed timestamp if called before timekeeping has resumed. */
> -       record->time = ns_to_timespec(ktime_get_real_fast_ns());
> +       record->time = ns_to_timespec64(ktime_get_real_fast_ns());
>  }
>
>  /*
> diff --git a/fs/pstore/ram.c b/fs/pstore/ram.c
> index 49b2bc114868..69e893076ab7 100644
> --- a/fs/pstore/ram.c
> +++ b/fs/pstore/ram.c
> @@ -38,6 +38,11 @@
>
>  #define RAMOOPS_KERNMSG_HDR "===="
>  #define MIN_MEM_SIZE 4096UL
> +#if __BITS_PER_LONG == 64
> +# define TVSEC_FMT "%ld"
> +#else
> +# define TVSEC_FMT "%lld"
> +#endif
>
>  static ulong record_size = MIN_MEM_SIZE;
>  module_param(record_size, ulong, 0400);
> @@ -153,21 +158,23 @@ ramoops_get_next_prz(struct persistent_ram_zone *przs[], uint *c, uint max,
>         return prz;
>  }
>
> -static int ramoops_read_kmsg_hdr(char *buffer, struct timespec *time,
> +static int ramoops_read_kmsg_hdr(char *buffer, struct timespec64 *time,
>                                   bool *compressed)
>  {
>         char data_type;
>         int header_length = 0;
>
> -       if (sscanf(buffer, RAMOOPS_KERNMSG_HDR "%lu.%lu-%c\n%n", &time->tv_sec,
> -                       &time->tv_nsec, &data_type, &header_length) == 3) {
> +       if (sscanf(buffer, RAMOOPS_KERNMSG_HDR TVSEC_FMT ".%lu-%c\n%n",
> +                  &time->tv_sec, &time->tv_nsec, &data_type,
> +                  &header_length) == 3) {
>                 if (data_type == 'C')
>                         *compressed = true;
>                 else
>                         *compressed = false;
> -       } else if (sscanf(buffer, RAMOOPS_KERNMSG_HDR "%lu.%lu\n%n",
> -                       &time->tv_sec, &time->tv_nsec, &header_length) == 2) {
> -                       *compressed = false;
> +       } else if (sscanf(buffer, RAMOOPS_KERNMSG_HDR TVSEC_FMT ".%lu\n%n",
> +                         &time->tv_sec, &time->tv_nsec,
> +                         &header_length) == 2) {
> +               *compressed = false;
>         } else {
>                 time->tv_sec = 0;
>                 time->tv_nsec = 0;
> @@ -360,7 +367,7 @@ static size_t ramoops_write_kmsg_hdr(struct persistent_ram_zone *prz,
>         char *hdr;
>         size_t len;
>
> -       hdr = kasprintf(GFP_ATOMIC, RAMOOPS_KERNMSG_HDR "%lu.%lu-%c\n",
> +       hdr = kasprintf(GFP_ATOMIC, RAMOOPS_KERNMSG_HDR TVSEC_FMT ".%lu-%c\n",
>                 record->time.tv_sec,
>                 record->time.tv_nsec / 1000,
>                 record->compressed ? 'C' : 'D');
> diff --git a/include/linux/pstore.h b/include/linux/pstore.h
> index 61f806a7fe29..a15bc4d48752 100644
> --- a/include/linux/pstore.h
> +++ b/include/linux/pstore.h
> @@ -71,7 +71,7 @@ struct pstore_record {
>         struct pstore_info      *psi;
>         enum pstore_type_id     type;
>         u64                     id;
> -       struct timespec         time;
> +       struct timespec64       time;
>         char                    *buf;
>         ssize_t                 size;
>         ssize_t                 ecc_notice_size;
> --
> 2.17.0
>
>
> --
> Kees Cook
> Pixel Security
