Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752059AbeERTFb (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 15:05:31 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:36912 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751452AbeERTF1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 15:05:27 -0400
X-Google-Smtp-Source: AB8JxZpWIMbpB5/oxhgIRea+XMgFRm7Kb18MWLis8m+SklzRj/MfyeXr5H9VxGn9/p9l4iSIq1LQyA==
From: Andreas Dilger <adilger@dilger.ca>
Message-Id: <905DA1CC-63F8-4020-A1D7-1F59ABDF3448@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_5E15DA95-13DE-4B27-81BE-98BDB58D3FFF";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH 10/10] Dynamic fault injection
Date: Fri, 18 May 2018 13:05:20 -0600
In-Reply-To: <20180518074918.13816-21-kent.overstreet@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Chinner <dchinner@redhat.com>, darrick.wong@oracle.com,
        tytso@mit.edu, linux-btrfs@vger.kernel.org, clm@fb.com, jbacik@fb.com,
        viro@zeniv.linux.org.uk, willy@infradead.org, peterz@infradead.org
To: Kent Overstreet <kent.overstreet@gmail.com>
References: <20180518074918.13816-1-kent.overstreet@gmail.com>
 <20180518074918.13816-21-kent.overstreet@gmail.com>
X-Mailer: Apple Mail (2.3273)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Apple-Mail=_5E15DA95-13DE-4B27-81BE-98BDB58D3FFF
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

On May 18, 2018, at 1:49 AM, Kent Overstreet <kent.overstreet@gmail.com> =
wrote:
>=20
> Signed-off-by: Kent Overstreet <kent.overstreet@gmail.com>

I agree with Christoph that even if there was some explanation in the =
cover
letter, there should be something at least as good in the patch itself.  =
The
cover letter is not saved, but the commit stays around forever, and =
should
explain how this should be added to code, and how to use it from =
userspace.


That said, I think this is a useful functionality.  We have something =
similar
in Lustre (OBD_FAIL_CHECK() and friends) that is necessary for being =
able to
test a distributed filesystem, which is just a CPP macro with an =
unlikely()
branch, while this looks more sophisticated.  This looks like it has =
some
added functionality like having more than one fault enabled at a time.
If this lands we could likely switch our code over to using this.


Some things that are missing from this patch that is in our code:

- in addition to the basic "enabled" and "oneshot" mechanisms, we have:
  - timeout: sleep for N msec to simulate network/disk/locking delays
  - race: wait with one thread until a second thread hits matching check

We also have a "fail_val" that allows making the check conditional (e.g.
only operation on server "N" should fail, only RPC opcode "N", etc).

Cheers, Andreas

> ---
> include/asm-generic/vmlinux.lds.h |   4 +
> include/linux/dynamic_fault.h     | 117 +++++
> lib/Kconfig.debug                 |   5 +
> lib/Makefile                      |   2 +
> lib/dynamic_fault.c               | 760 ++++++++++++++++++++++++++++++
> 5 files changed, 888 insertions(+)
> create mode 100644 include/linux/dynamic_fault.h
> create mode 100644 lib/dynamic_fault.c
>=20
> diff --git a/include/asm-generic/vmlinux.lds.h =
b/include/asm-generic/vmlinux.lds.h
> index 1ab0e520d6..a4c9dfcbbd 100644
> --- a/include/asm-generic/vmlinux.lds.h
> +++ b/include/asm-generic/vmlinux.lds.h
> @@ -246,6 +246,10 @@
> 	VMLINUX_SYMBOL(__start___verbose) =3D .;                         =
 \
> 	KEEP(*(__verbose))                                              =
\
> 	VMLINUX_SYMBOL(__stop___verbose) =3D .;				=
\
> +	. =3D ALIGN(8);							=
\
> +	VMLINUX_SYMBOL(__start___faults) =3D .;                          =
 \
> +	*(__faults)                                                     =
\
> +	VMLINUX_SYMBOL(__stop___faults) =3D .;				=
\
> 	LIKELY_PROFILE()		       				=
\
> 	BRANCH_PROFILE()						=
\
> 	TRACE_PRINTKS()							=
\
> diff --git a/include/linux/dynamic_fault.h =
b/include/linux/dynamic_fault.h
> new file mode 100644
> index 0000000000..6e7bb56ae8
> --- /dev/null
> +++ b/include/linux/dynamic_fault.h
> @@ -0,0 +1,117 @@
> +#ifndef _DYNAMIC_FAULT_H
> +#define _DYNAMIC_FAULT_H
> +
> +#include <linux/bio.h>
> +#include <linux/jump_label.h>
> +#include <linux/slab.h>
> +
> +enum dfault_enabled {
> +	DFAULT_DISABLED,
> +	DFAULT_ENABLED,
> +	DFAULT_ONESHOT,
> +};
> +
> +union dfault_state {
> +	struct {
> +		unsigned		enabled:2;
> +		unsigned		count:30;
> +	};
> +
> +	struct {
> +		unsigned		v;
> +	};
> +};
> +
> +/*
> + * An instance of this structure is created in a special
> + * ELF section at every dynamic fault callsite.  At runtime,
> + * the special section is treated as an array of these.
> + */
> +struct _dfault {
> +	const char		*modname;
> +	const char		*function;
> +	const char		*filename;
> +	const char		*class;
> +
> +	const u16		line;
> +
> +	unsigned		frequency;
> +	union dfault_state	state;
> +
> +	struct static_key	enabled;
> +} __aligned(8);
> +
> +
> +#ifdef CONFIG_DYNAMIC_FAULT
> +
> +int dfault_add_module(struct _dfault *tab, unsigned int n, const char =
*mod);
> +int dfault_remove_module(char *mod_name);
> +bool __dynamic_fault_enabled(struct _dfault *);
> +
> +#define dynamic_fault(_class)						=
\
> +({									=
\
> +	static struct _dfault descriptor				=
\
> +	__used __aligned(8) __attribute__((section("__faults"))) =3D {	=
\
> +		.modname	=3D KBUILD_MODNAME,			=
\
> +		.function	=3D __func__,				=
\
> +		.filename	=3D __FILE__,				=
\
> +		.line		=3D __LINE__,				=
\
> +		.class		=3D _class,				=
\
> +	};								=
\
> +									=
\
> +	static_key_false(&descriptor.enabled) &&			=
\
> +		__dynamic_fault_enabled(&descriptor);			=
\
> +})
> +
> +#define memory_fault()		dynamic_fault("memory")
> +#define race_fault()		dynamic_fault("race")
> +
> +#define kmalloc(...)							=
\
> +	(memory_fault() ? NULL	: kmalloc(__VA_ARGS__))
> +#define kzalloc(...)							=
\
> +	(memory_fault() ? NULL	: kzalloc(__VA_ARGS__))
> +#define krealloc(...)							=
\
> +	(memory_fault() ? NULL	: krealloc(__VA_ARGS__))
> +
> +#define mempool_alloc(pool, gfp_mask)					=
\
> +	((!gfpflags_allow_blocking(gfp_mask) && memory_fault())		=
\
> +		? NULL : mempool_alloc(pool, gfp_mask))
> +
> +#define __get_free_pages(...)						=
\
> +	(memory_fault() ? 0	: __get_free_pages(__VA_ARGS__))
> +#define alloc_pages_node(...)						=
\
> +	(memory_fault() ? NULL	: alloc_pages_node(__VA_ARGS__))
> +#define alloc_pages_nodemask(...)					=
\
> +	(memory_fault() ? NULL	: alloc_pages_nodemask(__VA_ARGS__))
> +
> +#define bio_alloc_bioset(gfp_mask, ...)					=
\
> +	((!gfpflags_allow_blocking(gfp_mask) && memory_fault())		=
\
> +	 ? NULL	: bio_alloc_bioset(gfp_mask, __VA_ARGS__))
> +
> +#define bio_clone(bio, gfp_mask)					=
\
> +	((!gfpflags_allow_blocking(gfp_mask) && memory_fault())		=
\
> +	 ? NULL	: bio_clone(bio, gfp_mask))
> +
> +#define bio_clone_bioset(bio, gfp_mask, bs)				=
\
> +	((!gfpflags_allow_blocking(gfp_mask) && memory_fault())		=
\
> +	 ? NULL	: bio_clone_bioset(bio, gfp_mask, bs))
> +
> +#define bio_kmalloc(...)						=
\
> +	(memory_fault() ? NULL		: bio_kmalloc(__VA_ARGS__))
> +#define bio_clone_kmalloc(...)						=
\
> +	(memory_fault() ? NULL		: =
bio_clone_kmalloc(__VA_ARGS__))
> +
> +#define bio_iov_iter_get_pages(...)					=
\
> +	(memory_fault() ? -ENOMEM	: =
bio_iov_iter_get_pages(__VA_ARGS__))
> +
> +#else /* CONFIG_DYNAMIC_FAULT */
> +
> +#define dfault_add_module(tab, n, modname)	0
> +#define dfault_remove_module(mod)		0
> +#define dynamic_fault(_class)			0
> +#define memory_fault()				0
> +#define race_fault()				0
> +
> +#endif /* CONFIG_DYNAMIC_FAULT */
> +
> +#endif
> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> index 427292a759..7b7ca0d813 100644
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -1599,6 +1599,11 @@ config LATENCYTOP
> 	  Enable this option if you want to use the LatencyTOP tool
> 	  to find out which userspace is blocking on what kernel =
operations.
>=20
> +config DYNAMIC_FAULT
> +	bool "Enable dynamic fault support"
> +	default n
> +	depends on DEBUG_FS
> +
> source kernel/trace/Kconfig
>=20
> config PROVIDE_OHCI1394_DMA_INIT
> diff --git a/lib/Makefile b/lib/Makefile
> index 66d2231d70..f6f70f4771 100644
> --- a/lib/Makefile
> +++ b/lib/Makefile
> @@ -158,6 +158,8 @@ obj-$(CONFIG_HAVE_ARCH_TRACEHOOK) +=3D syscall.o
>=20
> obj-$(CONFIG_DYNAMIC_DEBUG) +=3D dynamic_debug.o
>=20
> +obj-$(CONFIG_DYNAMIC_FAULT) +=3D dynamic_fault.o
> +
> obj-$(CONFIG_NLATTR) +=3D nlattr.o
>=20
> obj-$(CONFIG_LRU_CACHE) +=3D lru_cache.o
> diff --git a/lib/dynamic_fault.c b/lib/dynamic_fault.c
> new file mode 100644
> index 0000000000..75fc9a1b4b
> --- /dev/null
> +++ b/lib/dynamic_fault.c
> @@ -0,0 +1,760 @@
> +/*
> + * lib/dynamic_fault.c
> + *
> + * make dynamic_fault() calls runtime configurable based upon their
> + * source module.
> + *
> + * Copyright (C) 2011 Adam Berkan <aberkan@google.com>
> + * Based on dynamic_debug.c:
> + * Copyright (C) 2008 Jason Baron <jbaron@redhat.com>
> + * By Greg Banks <gnb@melbourne.sgi.com>
> + * Copyright (c) 2008 Silicon Graphics Inc.  All Rights Reserved.
> + *
> + */
> +
> +#define pr_fmt(fmt) "dfault: " fmt "\n"
> +
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/moduleparam.h>
> +#include <linux/kallsyms.h>
> +#include <linux/version.h>
> +#include <linux/types.h>
> +#include <linux/mutex.h>
> +#include <linux/proc_fs.h>
> +#include <linux/seq_file.h>
> +#include <linux/list.h>
> +#include <linux/sysctl.h>
> +#include <linux/ctype.h>
> +#include <linux/string.h>
> +#include <linux/uaccess.h>
> +#include <linux/dynamic_fault.h>
> +#include <linux/debugfs.h>
> +#include <linux/slab.h>
> +
> +#undef kzalloc
> +
> +extern struct _dfault __start___faults[];
> +extern struct _dfault __stop___faults[];
> +
> +struct dfault_table {
> +	struct list_head link;
> +	char *mod_name;
> +	unsigned int num_dfaults;
> +	struct _dfault *dfaults;
> +};
> +
> +struct dfault_query {
> +	const char	*filename;
> +	const char	*module;
> +	const char	*function;
> +	const char	*class;
> +	unsigned int	first_line, last_line;
> +	unsigned int	first_index, last_index;
> +
> +	unsigned	match_line:1;
> +	unsigned	match_index:1;
> +
> +	unsigned	set_enabled:1;
> +	unsigned	enabled:2;
> +
> +	unsigned	set_frequency:1;
> +	unsigned	frequency;
> +};
> +
> +struct dfault_iter {
> +	struct dfault_table *table;
> +	unsigned int idx;
> +};
> +
> +static DEFINE_MUTEX(dfault_lock);
> +static LIST_HEAD(dfault_tables);
> +
> +bool __dynamic_fault_enabled(struct _dfault *df)
> +{
> +	union dfault_state old, new;
> +	unsigned v =3D df->state.v;
> +	bool ret;
> +
> +	do {
> +		old.v =3D new.v =3D v;
> +
> +		if (new.enabled =3D=3D DFAULT_DISABLED)
> +			return false;
> +
> +		ret =3D df->frequency
> +			? ++new.count >=3D df->frequency
> +			: true;
> +		if (ret)
> +			new.count =3D 0;
> +		if (ret && new.enabled =3D=3D DFAULT_ONESHOT)
> +			new.enabled =3D DFAULT_DISABLED;
> +	} while ((v =3D cmpxchg(&df->state.v, old.v, new.v)) !=3D =
old.v);
> +
> +	if (ret)
> +		pr_debug("returned true for %s:%u", df->filename, =
df->line);
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL(__dynamic_fault_enabled);
> +
> +/* Return the last part of a pathname */
> +static inline const char *basename(const char *path)
> +{
> +	const char *tail =3D strrchr(path, '/');
> +
> +	return tail ? tail + 1 : path;
> +}
> +
> +/* format a string into buf[] which describes the _dfault's flags */
> +static char *dfault_describe_flags(struct _dfault *df, char *buf, =
size_t buflen)
> +{
> +	switch (df->state.enabled) {
> +	case DFAULT_DISABLED:
> +		strlcpy(buf, "disabled", buflen);
> +		break;
> +	case DFAULT_ENABLED:
> +		strlcpy(buf, "enabled", buflen);
> +		break;
> +	case DFAULT_ONESHOT:
> +		strlcpy(buf, "oneshot", buflen);
> +		break;
> +	default:
> +		BUG();
> +	}
> +
> +	return buf;
> +}
> +
> +/*
> + * must be called with dfault_lock held
> + */
> +
> +/*
> + * Search the tables for _dfault's which match the given
> + * `query' and apply the `flags' and `mask' to them.  Tells
> + * the user which dfault's were changed, or whether none
> + * were matched.
> + */
> +static int dfault_change(const struct dfault_query *query)
> +{
> +	struct dfault_table *dt;
> +	unsigned int nfound =3D 0;
> +	unsigned i, index =3D 0;
> +	char flagbuf[16];
> +
> +	/* search for matching dfaults */
> +	mutex_lock(&dfault_lock);
> +	list_for_each_entry(dt, &dfault_tables, link) {
> +
> +		/* match against the module name */
> +		if (query->module !=3D NULL &&
> +		    strcmp(query->module, dt->mod_name))
> +			continue;
> +
> +		for (i =3D 0 ; i < dt->num_dfaults ; i++) {
> +			struct _dfault *df =3D &dt->dfaults[i];
> +
> +			/* match against the source filename */
> +			if (query->filename !=3D NULL &&
> +			    strcmp(query->filename, df->filename) &&
> +			    strcmp(query->filename, =
basename(df->filename)))
> +				continue;
> +
> +			/* match against the function */
> +			if (query->function !=3D NULL &&
> +			    strcmp(query->function, df->function))
> +				continue;
> +
> +			/* match against the class */
> +			if (query->class) {
> +				size_t len =3D strlen(query->class);
> +
> +				if (strncmp(query->class, df->class, =
len))
> +					continue;
> +
> +				if (df->class[len] && df->class[len] !=3D =
':')
> +					continue;
> +			}
> +
> +			/* match against the line number range */
> +			if (query->match_line &&
> +			    (df->line < query->first_line ||
> +			     df->line > query->last_line))
> +				continue;
> +
> +			/* match against the fault index */
> +			if (query->match_index &&
> +			    (index < query->first_index ||
> +			     index > query->last_index)) {
> +				index++;
> +				continue;
> +			}
> +
> +			if (query->set_enabled &&
> +			    query->enabled !=3D df->state.enabled) {
> +				if (query->enabled !=3D DFAULT_DISABLED)
> +					=
static_key_slow_inc(&df->enabled);
> +				else if (df->state.enabled !=3D =
DFAULT_DISABLED)
> +					=
static_key_slow_dec(&df->enabled);
> +
> +				df->state.enabled =3D query->enabled;
> +			}
> +
> +			if (query->set_frequency)
> +				df->frequency =3D query->frequency;
> +
> +			pr_debug("changed %s:%d [%s]%s #%d %s",
> +				 df->filename, df->line, dt->mod_name,
> +				 df->function, index,
> +				 dfault_describe_flags(df, flagbuf,
> +						       =
sizeof(flagbuf)));
> +
> +			index++;
> +			nfound++;
> +		}
> +	}
> +	mutex_unlock(&dfault_lock);
> +
> +	pr_debug("dfault: %u matches", nfound);
> +
> +	return nfound ? 0 : -ENOENT;
> +}
> +
> +/*
> + * Split the buffer `buf' into space-separated words.
> + * Handles simple " and ' quoting, i.e. without nested,
> + * embedded or escaped \".  Return the number of words
> + * or <0 on error.
> + */
> +static int dfault_tokenize(char *buf, char *words[], int maxwords)
> +{
> +	int nwords =3D 0;
> +
> +	while (*buf) {
> +		char *end;
> +
> +		/* Skip leading whitespace */
> +		buf =3D skip_spaces(buf);
> +		if (!*buf)
> +			break;	/* oh, it was trailing whitespace */
> +
> +		/* Run `end' over a word, either whitespace separated or =
quoted
> +		 */
> +		if (*buf =3D=3D '"' || *buf =3D=3D '\'') {
> +			int quote =3D *buf++;
> +
> +			for (end =3D buf ; *end && *end !=3D quote ; =
end++)
> +				;
> +			if (!*end)
> +				return -EINVAL;	/* unclosed quote */
> +		} else {
> +			for (end =3D buf ; *end && !isspace(*end) ; =
end++)
> +				;
> +			BUG_ON(end =3D=3D buf);
> +		}
> +		/* Here `buf' is the start of the word, `end' is one =
past the
> +		 * end
> +		 */
> +
> +		if (nwords =3D=3D maxwords)
> +			return -EINVAL;	/* ran out of words[] before =
bytes */
> +		if (*end)
> +			*end++ =3D '\0';	/* terminate the word */
> +		words[nwords++] =3D buf;
> +		buf =3D end;
> +	}
> +
> +	return nwords;
> +}
> +
> +/*
> + * Parse a range.
> + */
> +static inline int parse_range(char *str,
> +			      unsigned int *first,
> +			      unsigned int *last)
> +{
> +	char *first_str =3D str;
> +	char *last_str =3D strchr(first_str, '-');
> +
> +	if (last_str)
> +		*last_str++ =3D '\0';
> +
> +	if (kstrtouint(first_str, 10, first))
> +		return -EINVAL;
> +
> +	if (!last_str)
> +		*last =3D *first;
> +	else if (kstrtouint(last_str, 10, last))
> +		return -EINVAL;
> +
> +	return 0;
> +}
> +
> +enum dfault_token {
> +	TOK_INVALID,
> +
> +	/* Queries */
> +	TOK_FUNC,
> +	TOK_FILE,
> +	TOK_LINE,
> +	TOK_MODULE,
> +	TOK_CLASS,
> +	TOK_INDEX,
> +
> +	/* Commands */
> +	TOK_DISABLE,
> +	TOK_ENABLE,
> +	TOK_ONESHOT,
> +	TOK_FREQUENCY,
> +};
> +
> +static const struct {
> +	const char		*str;
> +	enum dfault_token	tok;
> +	unsigned		args_required;
> +} dfault_token_strs[] =3D {
> +	{ "func",	TOK_FUNC,	1,	},
> +	{ "file",	TOK_FILE,	1,	},
> +	{ "line",	TOK_LINE,	1,	},
> +	{ "module",	TOK_MODULE,	1,	},
> +	{ "class",	TOK_CLASS,	1,	},
> +	{ "index",	TOK_INDEX,	1,	},
> +	{ "disable",	TOK_DISABLE,	0,	},
> +	{ "enable",	TOK_ENABLE,	0,	},
> +	{ "oneshot",	TOK_ONESHOT,	0,	},
> +	{ "frequency",	TOK_FREQUENCY,	1,	},
> +};
> +
> +static enum dfault_token str_to_token(const char *word, unsigned =
nr_words)
> +{
> +	unsigned i;
> +
> +	for (i =3D 0; i < ARRAY_SIZE(dfault_token_strs); i++)
> +		if (!strcmp(word, dfault_token_strs[i].str)) {
> +			if (nr_words < =
dfault_token_strs[i].args_required) {
> +				pr_debug("insufficient arguments to =
\"%s\"",
> +					 word);
> +				return TOK_INVALID;
> +			}
> +
> +			return dfault_token_strs[i].tok;
> +		}
> +
> +	pr_debug("unknown keyword \"%s\"", word);
> +
> +	return TOK_INVALID;
> +}
> +
> +static int dfault_parse_command(struct dfault_query *query,
> +				enum dfault_token tok,
> +				char *words[], size_t nr_words)
> +{
> +	unsigned i =3D 0;
> +	int ret;
> +
> +	switch (tok) {
> +	case TOK_INVALID:
> +		return -EINVAL;
> +	case TOK_FUNC:
> +		query->function =3D words[i++];
> +	case TOK_FILE:
> +		query->filename =3D words[i++];
> +		return 1;
> +	case TOK_LINE:
> +		ret =3D parse_range(words[i++],
> +				  &query->first_line,
> +				  &query->last_line);
> +		if (ret)
> +			return ret;
> +		query->match_line =3D true;
> +		break;
> +	case TOK_MODULE:
> +		query->module =3D words[i++];
> +		break;
> +	case TOK_CLASS:
> +		query->class =3D words[i++];
> +		break;
> +	case TOK_INDEX:
> +		ret =3D parse_range(words[i++],
> +				  &query->first_index,
> +				  &query->last_index);
> +		if (ret)
> +			return ret;
> +		query->match_index =3D true;
> +		break;
> +	case TOK_DISABLE:
> +		query->set_enabled =3D true;
> +		query->enabled =3D DFAULT_DISABLED;
> +		break;
> +	case TOK_ENABLE:
> +		query->set_enabled =3D true;
> +		query->enabled =3D DFAULT_ENABLED;
> +		break;
> +	case TOK_ONESHOT:
> +		query->set_enabled =3D true;
> +		query->enabled =3D DFAULT_ONESHOT;
> +		break;
> +	case TOK_FREQUENCY:
> +		query->set_frequency =3D 1;
> +		ret =3D kstrtouint(words[i++], 10, &query->frequency);
> +		if (ret)
> +			return ret;
> +
> +		if (!query->set_enabled) {
> +			query->set_enabled =3D 1;
> +			query->enabled =3D DFAULT_ENABLED;
> +		}
> +		break;
> +	}
> +
> +	return i;
> +}
> +
> +/*
> + * Parse words[] as a dfault query specification, which is a series
> + * of (keyword, value) pairs chosen from these possibilities:
> + *
> + * func <function-name>
> + * file <full-pathname>
> + * file <base-filename>
> + * module <module-name>
> + * line <lineno>
> + * line <first-lineno>-<last-lineno> // where either may be empty
> + * index <m>-<n>                     // dynamic faults numbered from =
<m>
> + *                                   // to <n> inside each matching =
function
> + */
> +static int dfault_parse_query(struct dfault_query *query,
> +			      char *words[], size_t nr_words)
> +{
> +	unsigned i =3D 0;
> +
> +	while (i < nr_words) {
> +		const char *tok_str =3D words[i++];
> +		enum dfault_token tok =3D str_to_token(tok_str, nr_words =
- i);
> +		int ret =3D dfault_parse_command(query, tok, words + i,
> +					       nr_words - i);
> +
> +		if (ret < 0)
> +			return ret;
> +		i +=3D ret;
> +		BUG_ON(i > nr_words);
> +	}
> +
> +	return 0;
> +}
> +
> +/*
> + * File_ops->write method for <debugfs>/dynamic_fault/conrol.  =
Gathers the
> + * command text from userspace, parses and executes it.
> + */
> +static ssize_t dfault_proc_write(struct file *file, const char __user =
*ubuf,
> +				  size_t len, loff_t *offp)
> +{
> +	struct dfault_query query;
> +#define MAXWORDS 9
> +	int nwords;
> +	char *words[MAXWORDS];
> +	char tmpbuf[256];
> +	int ret;
> +
> +	memset(&query, 0, sizeof(query));
> +
> +	if (len =3D=3D 0)
> +		return 0;
> +	/* we don't check *offp -- multiple writes() are allowed */
> +	if (len > sizeof(tmpbuf)-1)
> +		return -E2BIG;
> +	if (copy_from_user(tmpbuf, ubuf, len))
> +		return -EFAULT;
> +	tmpbuf[len] =3D '\0';
> +
> +	pr_debug("read %zu bytes from userspace", len);
> +
> +	nwords =3D dfault_tokenize(tmpbuf, words, MAXWORDS);
> +	if (nwords < 0)
> +		return -EINVAL;
> +	if (dfault_parse_query(&query, words, nwords))
> +		return -EINVAL;
> +
> +	/* actually go and implement the change */
> +	ret =3D dfault_change(&query);
> +	if (ret < 0)
> +		return ret;
> +
> +	*offp +=3D len;
> +	return len;
> +}
> +
> +/* Control file read code */
> +
> +/*
> + * Set the iterator to point to the first _dfault object
> + * and return a pointer to that first object.  Returns
> + * NULL if there are no _dfaults at all.
> + */
> +static struct _dfault *dfault_iter_first(struct dfault_iter *iter)
> +{
> +	if (list_empty(&dfault_tables)) {
> +		iter->table =3D NULL;
> +		iter->idx =3D 0;
> +		return NULL;
> +	}
> +	iter->table =3D list_entry(dfault_tables.next,
> +				 struct dfault_table, link);
> +	iter->idx =3D 0;
> +	return &iter->table->dfaults[iter->idx];
> +}
> +
> +/*
> + * Advance the iterator to point to the next _dfault
> + * object from the one the iterator currently points at,
> + * and returns a pointer to the new _dfault.  Returns
> + * NULL if the iterator has seen all the _dfaults.
> + */
> +static struct _dfault *dfault_iter_next(struct dfault_iter *iter)
> +{
> +	if (iter->table =3D=3D NULL)
> +		return NULL;
> +	if (++iter->idx =3D=3D iter->table->num_dfaults) {
> +		/* iterate to next table */
> +		iter->idx =3D 0;
> +		if (list_is_last(&iter->table->link, &dfault_tables)) {
> +			iter->table =3D NULL;
> +			return NULL;
> +		}
> +		iter->table =3D list_entry(iter->table->link.next,
> +					 struct dfault_table, link);
> +	}
> +	return &iter->table->dfaults[iter->idx];
> +}
> +
> +/*
> + * Seq_ops start method.  Called at the start of every
> + * read() call from userspace.  Takes the dfault_lock and
> + * seeks the seq_file's iterator to the given position.
> + */
> +static void *dfault_proc_start(struct seq_file *m, loff_t *pos)
> +{
> +	struct dfault_iter *iter =3D m->private;
> +	struct _dfault *dp;
> +	int n =3D *pos;
> +
> +	mutex_lock(&dfault_lock);
> +
> +	if (n < 0)
> +		return NULL;
> +	dp =3D dfault_iter_first(iter);
> +	while (dp !=3D NULL && --n >=3D 0)
> +		dp =3D dfault_iter_next(iter);
> +	return dp;
> +}
> +
> +/*
> + * Seq_ops next method.  Called several times within a read()
> + * call from userspace, with dfault_lock held.  Walks to the
> + * next _dfault object with a special case for the header line.
> + */
> +static void *dfault_proc_next(struct seq_file *m, void *p, loff_t =
*pos)
> +{
> +	struct dfault_iter *iter =3D m->private;
> +	struct _dfault *dp;
> +
> +	if (p =3D=3D SEQ_START_TOKEN)
> +		dp =3D dfault_iter_first(iter);
> +	else
> +		dp =3D dfault_iter_next(iter);
> +	++*pos;
> +	return dp;
> +}
> +
> +/*
> + * Seq_ops show method.  Called several times within a read()
> + * call from userspace, with dfault_lock held.  Formats the
> + * current _dfault as a single human-readable line, with a
> + * special case for the header line.
> + */
> +static int dfault_proc_show(struct seq_file *m, void *p)
> +{
> +	struct dfault_iter *iter =3D m->private;
> +	struct _dfault *df =3D p;
> +	char flagsbuf[8];
> +
> +	seq_printf(m, "%s:%u class:%s module:%s func:%s %s \"\"\n",
> +		   df->filename, df->line, df->class,
> +		   iter->table->mod_name, df->function,
> +		   dfault_describe_flags(df, flagsbuf, =
sizeof(flagsbuf)));
> +
> +	return 0;
> +}
> +
> +/*
> + * Seq_ops stop method.  Called at the end of each read()
> + * call from userspace.  Drops dfault_lock.
> + */
> +static void dfault_proc_stop(struct seq_file *m, void *p)
> +{
> +	mutex_unlock(&dfault_lock);
> +}
> +
> +static const struct seq_operations dfault_proc_seqops =3D {
> +	.start =3D dfault_proc_start,
> +	.next =3D dfault_proc_next,
> +	.show =3D dfault_proc_show,
> +	.stop =3D dfault_proc_stop
> +};
> +
> +/*
> + * File_ops->open method for <debugfs>/dynamic_fault/control.  Does =
the seq_file
> + * setup dance, and also creates an iterator to walk the _dfaults.
> + * Note that we create a seq_file always, even for O_WRONLY files
> + * where it's not needed, as doing so simplifies the ->release =
method.
> + */
> +static int dfault_proc_open(struct inode *inode, struct file *file)
> +{
> +	struct dfault_iter *iter;
> +	int err;
> +
> +	iter =3D kzalloc(sizeof(*iter), GFP_KERNEL);
> +	if (iter =3D=3D NULL)
> +		return -ENOMEM;
> +
> +	err =3D seq_open(file, &dfault_proc_seqops);
> +	if (err) {
> +		kfree(iter);
> +		return err;
> +	}
> +	((struct seq_file *) file->private_data)->private =3D iter;
> +	return 0;
> +}
> +
> +static const struct file_operations dfault_proc_fops =3D {
> +	.owner =3D THIS_MODULE,
> +	.open =3D dfault_proc_open,
> +	.read =3D seq_read,
> +	.llseek =3D seq_lseek,
> +	.release =3D seq_release_private,
> +	.write =3D dfault_proc_write
> +};
> +
> +/*
> + * Allocate a new dfault_table for the given module
> + * and add it to the global list.
> + */
> +int dfault_add_module(struct _dfault *tab, unsigned int n,
> +		      const char *name)
> +{
> +	struct dfault_table *dt;
> +	char *new_name;
> +	const char *func =3D NULL;
> +	int i;
> +
> +	dt =3D kzalloc(sizeof(*dt), GFP_KERNEL);
> +	if (dt =3D=3D NULL)
> +		return -ENOMEM;
> +	new_name =3D kstrdup(name, GFP_KERNEL);
> +	if (new_name =3D=3D NULL) {
> +		kfree(dt);
> +		return -ENOMEM;
> +	}
> +	dt->mod_name =3D new_name;
> +	dt->num_dfaults =3D n;
> +	dt->dfaults =3D tab;
> +
> +	mutex_lock(&dfault_lock);
> +	list_add_tail(&dt->link, &dfault_tables);
> +	mutex_unlock(&dfault_lock);
> +
> +	/* __attribute__(("section")) emits things in reverse order */
> +	for (i =3D n - 1; i >=3D 0; i--)
> +		if (!func || strcmp(tab[i].function, func))
> +			func =3D tab[i].function;
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(dfault_add_module);
> +
> +static void dfault_table_free(struct dfault_table *dt)
> +{
> +	list_del_init(&dt->link);
> +	kfree(dt->mod_name);
> +	kfree(dt);
> +}
> +
> +/*
> + * Called in response to a module being unloaded.  Removes
> + * any dfault_table's which point at the module.
> + */
> +int dfault_remove_module(char *mod_name)
> +{
> +	struct dfault_table *dt, *nextdt;
> +	int ret =3D -ENOENT;
> +
> +	mutex_lock(&dfault_lock);
> +	list_for_each_entry_safe(dt, nextdt, &dfault_tables, link) {
> +		if (!strcmp(dt->mod_name, mod_name)) {
> +			dfault_table_free(dt);
> +			ret =3D 0;
> +		}
> +	}
> +	mutex_unlock(&dfault_lock);
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(dfault_remove_module);
> +
> +static void dfault_remove_all_tables(void)
> +{
> +	mutex_lock(&dfault_lock);
> +	while (!list_empty(&dfault_tables)) {
> +		struct dfault_table *dt =3D =
list_entry(dfault_tables.next,
> +						      struct =
dfault_table,
> +						      link);
> +		dfault_table_free(dt);
> +	}
> +	mutex_unlock(&dfault_lock);
> +}
> +
> +static int __init dynamic_fault_init(void)
> +{
> +	struct dentry *dir, *file;
> +	struct _dfault *iter, *iter_start;
> +	const char *modname =3D NULL;
> +	int ret =3D 0;
> +	int n =3D 0;
> +
> +	dir =3D debugfs_create_dir("dynamic_fault", NULL);
> +	if (!dir)
> +		return -ENOMEM;
> +	file =3D debugfs_create_file("control", 0644, dir, NULL,
> +					&dfault_proc_fops);
> +	if (!file) {
> +		debugfs_remove(dir);
> +		return -ENOMEM;
> +	}
> +	if (__start___faults !=3D __stop___faults) {
> +		iter =3D __start___faults;
> +		modname =3D iter->modname;
> +		iter_start =3D iter;
> +		for (; iter < __stop___faults; iter++) {
> +			if (strcmp(modname, iter->modname)) {
> +				ret =3D dfault_add_module(iter_start, n, =
modname);
> +				if (ret)
> +					goto out_free;
> +				n =3D 0;
> +				modname =3D iter->modname;
> +				iter_start =3D iter;
> +			}
> +			n++;
> +		}
> +		ret =3D dfault_add_module(iter_start, n, modname);
> +	}
> +out_free:
> +	if (ret) {
> +		dfault_remove_all_tables();
> +		debugfs_remove(dir);
> +		debugfs_remove(file);
> +	}
> +	return 0;
> +}
> +module_init(dynamic_fault_init);
> --
> 2.17.0
>=20


Cheers, Andreas






--Apple-Mail=_5E15DA95-13DE-4B27-81BE-98BDB58D3FFF
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAlr/I/AACgkQcqXauRfM
H+BCDg//cCUhgxGu/IBxO0aH0X3l2W23ERjmvbVSCxZVH9s9dIrKSyT9h2bzYebn
WBCZ6a+pOr+rVEK7eRlI//oouHyrET8OxNqor7uoEYF+JpJyhDC6CWl1Be5nDGi7
gBnimLZ70iBDTmkecxz9ZQEgqngp5NNt8L8poSpe3Mk0AixBvkHitA/YYzUEgx5g
6+jCUEA+e2W8KL8rI0If+vfpLAL/9gOMnIjnTb2+N2I8QqUm+zwbjsHPHOxmKSlq
0N/aAQ+ZpbEqK3VBx9yFUMbISpU5jUzBmNrnPAbM62+kUkrA5J0BuEXpxtk/tzM9
9bKLLp4oCYK/kJw4UAsok89wsdvbkouVAY4WopkEnjwO8CSQd+CU07Z8pEmKVmlc
GXo3mpV5/hFdeiLxg+2SF0FPB0WRWjS8I7hNQUqq3GwEJ/RRNGEfMbAQ7MwtspXf
WX0XyF9B5exsvG/c5q0hE53uhpy6AjjHVhpciGO6WClN7Fmnv7V2hGW7cSaolxvn
LOXDfPPqwY04X8GpY9kjiFNEGjXhrc+KtQdexMxK69VZGbnQ80CSia57wp4dt6/A
1KdZHvraIq4nqfL1aPUrVGfheXPH2E1NHmC/RgdLvotJvyQMBAbayZbG/aqBRQdr
c5MlhXJwkVRKPBkfv1mGsk9fryVjHyb5Ro5c2ma/l3YWlxhhtmc=
=5iVE
-----END PGP SIGNATURE-----

--Apple-Mail=_5E15DA95-13DE-4B27-81BE-98BDB58D3FFF--
