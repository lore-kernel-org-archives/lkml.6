Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750987AbeEaU5g convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 16:57:36 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:59714 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750852AbeEaU50 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 16:57:26 -0400
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <152720693123.9073.4511934790831409009.stgit@warthog.procyon.org.uk>
References: <152720693123.9073.4511934790831409009.stgit@warthog.procyon.org.uk> <152720672288.9073.9868393448836301272.stgit@warthog.procyon.org.uk>
Cc: dhowells@redhat.com, viro@zeniv.linux.org.uk,
        linux-fsdevel@vger.kernel.org, linux-afs@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: fsinfo test program
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <32053.1527800244.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: 8BIT
Date: Thu, 31 May 2018 21:57:24 +0100
Message-ID: <32054.1527800244@warthog.procyon.org.uk>
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

/* Test the fsinfo() system call
 *
 * Copyright (C) 2018 Red Hat, Inc. All Rights Reserved.
 * Written by David Howells (dhowells@redhat.com)
 *
 * This program is free software; you can redistribute it and/or
 * modify it under the terms of the GNU General Public Licence
 * as published by the Free Software Foundation; either version
 * 2 of the Licence, or (at your option) any later version.
 */

#define _GNU_SOURCE
#define _ATFILE_SOURCE
#include <stdbool.h>
#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <string.h>
#include <unistd.h>
#include <ctype.h>
#include <errno.h>
#include <time.h>
#include <math.h>
#include <fcntl.h>
#include <sys/syscall.h>
#include <linux/stat.h>
#include <linux/socket.h>
#include <sys/stat.h>

#define __NR_fsinfo 338
enum fsinfo_attribute {
	fsinfo_attr_statfs		= 0,	/* statfs()-style state */
	fsinfo_attr_fsinfo		= 1,	/* Information about fsinfo() */
	fsinfo_attr_ids			= 2,	/* Filesystem IDs */
	fsinfo_attr_limits		= 3,	/* Filesystem limits */
	fsinfo_attr_supports		= 4,	/* What's supported in statx, iocflags, ... */
	fsinfo_attr_capabilities	= 5,	/* Filesystem capabilities (bits) */
	fsinfo_attr_timestamp_info	= 6,	/* Inode timestamp info */
	fsinfo_attr_volume_id		= 7,	/* Volume ID (string) */
	fsinfo_attr_volume_uuid		= 8,	/* Volume UUID (LE uuid) */
	fsinfo_attr_volume_name		= 9,	/* Volume name (string) */
	fsinfo_attr_cell_name		= 10,	/* Cell name (string) */
	fsinfo_attr_domain_name		= 11,	/* Domain name (string) */
	fsinfo_attr_realm_name		= 12,	/* Realm name (string) */
	fsinfo_attr_server_name		= 13,	/* Name of the Nth server */
	fsinfo_attr_server_address	= 14,	/* Mth address of the Nth server */
	fsinfo_attr_error_state		= 15,	/* Error state */
	fsinfo_attr_parameter		= 16,	/* Nth mount parameter (string) */
	fsinfo_attr_source		= 17,	/* Nth mount source name (string) */
	fsinfo_attr_name_encoding	= 18,	/* Filename encoding (string) */
	fsinfo_attr_name_codepage	= 19,	/* Filename codepage (string) */
	fsinfo_attr_io_size		= 20,	/* Optimal I/O sizes */
	fsinfo_attr__nr
};

struct fsinfo_params {
	enum fsinfo_attribute	request;	/* What is being asking for */
	__u32			Nth;		/* Instance of it (some may have multiple) */
	__u32			Mth;		/* Subinstance of Nth instance */
	__u32			at_flags;	/* AT_SYMLINK_NOFOLLOW and similar flags */
	__u32			__reserved[6];	/* Reserved params; all must be 0 */
};

struct fsinfo_statfs {
	__u64	f_blocks;	/* Total number of blocks in fs */
	__u64	f_bfree;	/* Total number of free blocks */
	__u64	f_bavail;	/* Number of free blocks available to ordinary user */
	__u64	f_files;	/* Total number of file nodes in fs */
	__u64	f_ffree;	/* Number of free file nodes */
	__u64	f_favail;	/* Number of free file nodes available to ordinary user */
	__u32	f_bsize;	/* Optimal block size */
	__u32	f_frsize;	/* Fragment size */
};

struct fsinfo_ids {
	char	f_fs_name[15 + 1];
	__u64	f_flags;	/* Filesystem mount flags (MS_*) */
	__u64	f_fsid;		/* Short 64-bit Filesystem ID (as statfs) */
	__u64	f_sb_id;	/* Internal superblock ID for sbnotify()/mntnotify() */
	__u32	f_fstype;	/* Filesystem type from linux/magic.h [uncond] */
	__u32	f_dev_major;	/* As st_dev_* from struct statx [uncond] */
	__u32	f_dev_minor;
};

struct fsinfo_limits {
	__u64	max_file_size;			/* Maximum file size */
	__u64	max_uid;			/* Maximum UID supported */
	__u64	max_gid;			/* Maximum GID supported */
	__u64	max_projid;			/* Maximum project ID supported */
	__u32	max_dev_major;			/* Maximum device major representable */
	__u32	max_dev_minor;			/* Maximum device minor representable */
	__u32	max_hard_links;			/* Maximum number of hard links on a file */
	__u32	max_xattr_body_len;		/* Maximum xattr content length */
	__u16	max_xattr_name_len;		/* Maximum xattr name length */
	__u16	max_filename_len;		/* Maximum filename length */
	__u16	max_symlink_len;		/* Maximum symlink content length */
	__u16	__spare;
};

struct fsinfo_supports {
	__u64	supported_stx_attributes;	/* What statx::stx_attributes are supported */
	__u32	supported_stx_mask;		/* What statx::stx_mask bits are supported */
	__u32	supported_ioc_flags;		/* What FS_IOC_* flags are supported */
};

enum fsinfo_capability {
	fsinfo_cap_is_kernel_fs		= 0,	/* fs is kernel-special filesystem */
	fsinfo_cap_is_block_fs		= 1,	/* fs is block-based filesystem */
	fsinfo_cap_is_flash_fs		= 2,	/* fs is flash filesystem */
	fsinfo_cap_is_network_fs	= 3,	/* fs is network filesystem */
	fsinfo_cap_is_automounter_fs	= 4,	/* fs is automounter special filesystem */
	fsinfo_cap_automounts		= 5,	/* fs supports automounts */
	fsinfo_cap_adv_locks		= 6,	/* fs supports advisory file locking */
	fsinfo_cap_mand_locks		= 7,	/* fs supports mandatory file locking */
	fsinfo_cap_leases		= 8,	/* fs supports file leases */
	fsinfo_cap_uids			= 9,	/* fs supports numeric uids */
	fsinfo_cap_gids			= 10,	/* fs supports numeric gids */
	fsinfo_cap_projids		= 11,	/* fs supports numeric project ids */
	fsinfo_cap_id_names		= 12,	/* fs supports user names */
	fsinfo_cap_id_guids		= 13,	/* fs supports user guids */
	fsinfo_cap_windows_attrs	= 14,	/* fs has windows attributes */
	fsinfo_cap_user_quotas		= 15,	/* fs has per-user quotas */
	fsinfo_cap_group_quotas		= 16,	/* fs has per-group quotas */
	fsinfo_cap_project_quotas	= 17,	/* fs has per-project quotas */
	fsinfo_cap_xattrs		= 18,	/* fs has xattrs */
	fsinfo_cap_journal		= 19,	/* fs has a journal */
	fsinfo_cap_data_is_journalled	= 20,	/* fs is using data journalling */
	fsinfo_cap_o_sync		= 21,	/* fs supports O_SYNC */
	fsinfo_cap_o_direct		= 22,	/* fs supports O_DIRECT */
	fsinfo_cap_volume_id		= 23,	/* fs has a volume ID */
	fsinfo_cap_volume_uuid		= 24,	/* fs has a volume UUID */
	fsinfo_cap_volume_name		= 25,	/* fs has a volume name */
	fsinfo_cap_volume_fsid		= 26,	/* fs has a volume FSID */
	fsinfo_cap_cell_name		= 27,	/* fs has a cell name */
	fsinfo_cap_domain_name		= 28,	/* fs has a domain name */
	fsinfo_cap_realm_name		= 29,	/* fs has a realm name */
	fsinfo_cap_iver_all_change	= 30,	/* i_version represents data + meta changes */
	fsinfo_cap_iver_data_change	= 31,	/* i_version represents data changes only */
	fsinfo_cap_iver_mono_incr	= 32,	/* i_version incremented monotonically */
	fsinfo_cap_symlinks		= 33,	/* fs supports symlinks */
	fsinfo_cap_hard_links		= 34,	/* fs supports hard links */
	fsinfo_cap_hard_links_1dir	= 35,	/* fs supports hard links in same dir only */
	fsinfo_cap_device_files		= 36,	/* fs supports bdev, cdev */
	fsinfo_cap_unix_specials	= 37,	/* fs supports pipe, fifo, socket */
	fsinfo_cap_resource_forks	= 38,	/* fs supports resource forks/streams */
	fsinfo_cap_name_case_indep	= 39,	/* Filename case independence is mandatory */
	fsinfo_cap_name_non_utf8	= 40,	/* fs has non-utf8 names */
	fsinfo_cap_name_has_codepage	= 41,	/* fs has a filename codepage */
	fsinfo_cap_sparse		= 42,	/* fs supports sparse files */
	fsinfo_cap_not_persistent	= 43,	/* fs is not persistent */
	fsinfo_cap_no_unix_mode		= 44,	/* fs does not support unix mode bits */
	fsinfo_cap_has_atime		= 45,	/* fs supports access time */
	fsinfo_cap_has_btime		= 46,	/* fs supports birth/creation time */
	fsinfo_cap_has_ctime		= 47,	/* fs supports change time */
	fsinfo_cap_has_mtime		= 48,	/* fs supports modification time */
	fsinfo_cap__nr
};

struct fsinfo_capabilities {
	__u8	capabilities[(fsinfo_cap__nr + 7) / 8];
};

struct fsinfo_timestamp_info {
	__s64	minimum_timestamp;	/* Minimum timestamp value in seconds */
	__s64	maximum_timestamp;	/* Maximum timestamp value in seconds */
	__u16	atime_gran_mantissa;	/* Granularity(secs) = mant * 10^exp */
	__u16	btime_gran_mantissa;
	__u16	ctime_gran_mantissa;
	__u16	mtime_gran_mantissa;
	__s8	atime_gran_exponent;
	__s8	btime_gran_exponent;
	__s8	ctime_gran_exponent;
	__s8	mtime_gran_exponent;
};

struct fsinfo_volume_uuid {
	__u8	uuid[16];
};

struct fsinfo_server_address {
	struct __kernel_sockaddr_storage address;
};

struct fsinfo_error_state {
	__u32		io_error;	/* General I/O error counter */
	__u32		wb_error;	/* Writeback error counter */
	__u32		bdev_error;	/* Blockdev error counter */
};

struct fsinfo_io_size {
	__u32		block_size;		/* Minimum block granularity for O_DIRECT */
	__u32		max_single_read_size;	/* Maximum size of a single unbuffered read */
	__u32		max_single_write_size;	/* Maximum size of a single unbuffered write */
	__u32		best_read_size;		/* Optimal read size */
	__u32		best_write_size;	/* Optimal write size */
};

struct fsinfo_fsinfo {
	enum fsinfo_attribute	max_attr;	/* Number of supported attributes */
	enum fsinfo_capability	max_cap;	/* Number of supported capabilities */
};

/*****************************************************************************/
/*****************************************************************************/
/*****************************************************************************/
static __attribute__((unused))
ssize_t fsinfo(int dfd, const char *filename, struct fsinfo_params *params,
	       void *buffer, size_t buf_size)
{
	return syscall(__NR_fsinfo, dfd, filename, params, buffer, buf_size);
}

#define FSINFO_STRING(N)	 [fsinfo_attr_##N] = 0x00
#define FSINFO_STRUCT(N)	 [fsinfo_attr_##N] = sizeof(struct fsinfo_##N)/sizeof(__u32)
#define FSINFO_STRING_N(N)	 [fsinfo_attr_##N] = 0x40
#define FSINFO_STRUCT_N(N)	 [fsinfo_attr_##N] = 0x40 | sizeof(struct fsinfo_##N)/sizeof(__u32)
#define FSINFO_STRUCT_NM(N)	 [fsinfo_attr_##N] = 0x80 | sizeof(struct fsinfo_##N)/sizeof(__u32)
static const __u8 fsinfo_buffer_sizes[fsinfo_attr__nr] = {
	FSINFO_STRUCT		(statfs),
	FSINFO_STRUCT		(fsinfo),
	FSINFO_STRUCT		(ids),
	FSINFO_STRUCT		(limits),
	FSINFO_STRUCT		(supports),
	FSINFO_STRUCT		(capabilities),
	FSINFO_STRUCT		(timestamp_info),
	FSINFO_STRING		(volume_id),
	FSINFO_STRUCT		(volume_uuid),
	FSINFO_STRING		(volume_name),
	FSINFO_STRING		(cell_name),
	FSINFO_STRING		(domain_name),
	FSINFO_STRING		(realm_name),
	FSINFO_STRING_N		(server_name),
	FSINFO_STRUCT_NM	(server_address),
	FSINFO_STRUCT		(error_state),
	FSINFO_STRING_N		(parameter),
	FSINFO_STRING_N		(source),
	FSINFO_STRING		(name_encoding),
	FSINFO_STRING		(name_codepage),
	FSINFO_STRUCT		(io_size),
};

#define FSINFO_NAME(N) [fsinfo_attr_##N] = #N
static const char *fsinfo_attr_names[fsinfo_attr__nr] = {
	FSINFO_NAME(statfs),
	FSINFO_NAME(fsinfo),
	FSINFO_NAME(ids),
	FSINFO_NAME(limits),
	FSINFO_NAME(supports),
	FSINFO_NAME(capabilities),
	FSINFO_NAME(timestamp_info),
	FSINFO_NAME(volume_id),
	FSINFO_NAME(volume_uuid),
	FSINFO_NAME(volume_name),
	FSINFO_NAME(cell_name),
	FSINFO_NAME(domain_name),
	FSINFO_NAME(realm_name),
	FSINFO_NAME(server_name),
	FSINFO_NAME(server_address),
	FSINFO_NAME(error_state),
	FSINFO_NAME(parameter),
	FSINFO_NAME(source),
	FSINFO_NAME(name_encoding),
	FSINFO_NAME(name_codepage),
	FSINFO_NAME(io_size),
};

union reply {
	char buffer[4096];
	struct fsinfo_statfs statfs;
	struct fsinfo_fsinfo fsinfo;
	struct fsinfo_ids ids;
	struct fsinfo_limits limits;
	struct fsinfo_supports supports;
	struct fsinfo_capabilities caps;
	struct fsinfo_timestamp_info timestamps;
	struct fsinfo_volume_uuid uuid;
	struct fsinfo_server_address srv_addr;
	struct fsinfo_error_state errors;
	struct fsinfo_io_size io_size;
};

/*
 * Dump as hex.
 */
static void dump_hex(unsigned int *data, int from, int to)
{
	unsigned offset, print_offset = 1, col = 0;

	from /= 4;
	to = (to + 3) / 4;

	for (offset = from; offset < to; offset++) {
		if (print_offset) {
			printf("%04x: ", offset * 8);
			print_offset = 0;
		}
		printf("%08x", data[offset]);
		col++;
		if ((col & 3) == 0) {
			printf("\n");
			print_offset = 1;
		} else {
			printf(" ");
		}
	}

	if (!print_offset)
		printf("\n");
}

#if 0
static void dump_fsinfo(struct fsinfo *f)
{
	printf("ioc   : %llx\n", (unsigned long long)f->f_supported_ioc_flags);

	if (f->f_mask & FSINFO_VOLUME_ID) {
		int printable = 1, loop;
		printf("volid : ");
		for (loop = 0; loop < sizeof(f->f_volume_id); loop++)
			if (!isprint(f->f_volume_id[loop]))
				printable = 0;
		if (printable) {
			printf("'%.*s'", 16, f->f_volume_id);
		} else {
			for (loop = 0; loop < sizeof(f->f_volume_id); loop++) {
				if (loop % 4 == 0 && loop != 0)
					printf(" ");
				printf("%02x", f->f_volume_id[loop]);
			}
		}
		printf("\n");
	}
}
#endif

static void dump_attr_statfs(union reply *r, int size)
{
	struct fsinfo_statfs *f = &r->statfs;
	
	printf("\tblocks: n=%llu fr=%llu av=%llu\n",
	       (unsigned long long)f->f_blocks,
	       (unsigned long long)f->f_bfree,
	       (unsigned long long)f->f_bavail);

	printf("\tfiles : n=%llu fr=%llu av=%llu\n",
	       (unsigned long long)f->f_files,
	       (unsigned long long)f->f_ffree,
	       (unsigned long long)f->f_favail);
	printf("\tbsize : %u\n", f->f_bsize);
	printf("\tfrsize: %u\n", f->f_frsize);
}

static void dump_attr_fsinfo(union reply *r, int size)
{
	struct fsinfo_fsinfo *f = &r->fsinfo;

	printf("max_attr=%u max_cap=%u\n", f->max_attr, f->max_cap);
}

static void dump_attr_ids(union reply *r, int size)
{
	struct fsinfo_ids *f = &r->ids;

	printf("dev   : %02x:%02x\n", f->f_dev_major, f->f_dev_minor);
	printf("\tfs    : type=%x name=%s\n", f->f_fstype, f->f_fs_name);
	printf("\tflags : %llx\n", (unsigned long long)f->f_flags);
	printf("\tfsid  : %llx\n", (unsigned long long)f->f_fsid);
}

static void dump_attr_limits(union reply *r, int size)
{
	struct fsinfo_limits *f = &r->limits;

	printf("max file size: %llx\n", f->max_file_size);
}

static void dump_attr_supports(union reply *r, int size)
{
	struct fsinfo_supports *f = &r->supports;

	printf("stx_attr=%llx\n", f->supported_stx_attributes);
}

#define FSINFO_CAP_NAME(C) [fsinfo_cap_##C] = #C
static const char *fsinfo_cap_names[fsinfo_cap__nr] = {
	FSINFO_CAP_NAME(is_kernel_fs),
	FSINFO_CAP_NAME(is_block_fs),
	FSINFO_CAP_NAME(is_flash_fs),
	FSINFO_CAP_NAME(is_network_fs),
	FSINFO_CAP_NAME(is_automounter_fs),
	FSINFO_CAP_NAME(automounts),
	FSINFO_CAP_NAME(adv_locks),
	FSINFO_CAP_NAME(mand_locks),
	FSINFO_CAP_NAME(leases),
	FSINFO_CAP_NAME(uids),
	FSINFO_CAP_NAME(gids),
	FSINFO_CAP_NAME(projids),
	FSINFO_CAP_NAME(id_names),
	FSINFO_CAP_NAME(id_guids),
	FSINFO_CAP_NAME(windows_attrs),
	FSINFO_CAP_NAME(user_quotas),
	FSINFO_CAP_NAME(group_quotas),
	FSINFO_CAP_NAME(project_quotas),
	FSINFO_CAP_NAME(xattrs),
	FSINFO_CAP_NAME(journal),
	FSINFO_CAP_NAME(data_is_journalled),
	FSINFO_CAP_NAME(o_sync),
	FSINFO_CAP_NAME(o_direct),
	FSINFO_CAP_NAME(volume_id),
	FSINFO_CAP_NAME(volume_uuid),
	FSINFO_CAP_NAME(volume_name),
	FSINFO_CAP_NAME(volume_fsid),
	FSINFO_CAP_NAME(cell_name),
	FSINFO_CAP_NAME(domain_name),
	FSINFO_CAP_NAME(realm_name),
	FSINFO_CAP_NAME(iver_all_change),
	FSINFO_CAP_NAME(iver_data_change),
	FSINFO_CAP_NAME(iver_mono_incr),
	FSINFO_CAP_NAME(symlinks),
	FSINFO_CAP_NAME(hard_links),
	FSINFO_CAP_NAME(hard_links_1dir),
	FSINFO_CAP_NAME(device_files),
	FSINFO_CAP_NAME(unix_specials),
	FSINFO_CAP_NAME(resource_forks),
	FSINFO_CAP_NAME(name_case_indep),
	FSINFO_CAP_NAME(name_non_utf8),
	FSINFO_CAP_NAME(name_has_codepage),
	FSINFO_CAP_NAME(sparse),
	FSINFO_CAP_NAME(not_persistent),
	FSINFO_CAP_NAME(no_unix_mode),
	FSINFO_CAP_NAME(has_atime),
	FSINFO_CAP_NAME(has_btime),
	FSINFO_CAP_NAME(has_ctime),
	FSINFO_CAP_NAME(has_mtime),
};

static void dump_attr_capabilities(union reply *r, int size)
{
	struct fsinfo_capabilities *f = &r->caps;
	int i;

	for (i = 0; i < sizeof(f->capabilities); i++)
		printf("%02x", f->capabilities[i]);
	printf("\n");
	for (i = 0; i < fsinfo_cap__nr; i++)
		if (f->capabilities[i / 8] & (1 << (i % 8)))
			printf("\t- %s\n", fsinfo_cap_names[i]);
}

static void dump_attr_timestamp_info(union reply *r, int size)
{
	struct fsinfo_timestamp_info *f = &r->timestamps;

	printf("range=%llx-%llx\n",
	       (unsigned long long)f->minimum_timestamp,
	       (unsigned long long)f->maximum_timestamp);

#define print_time(G) \
	printf("\t"#G"time : gran=%gs\n",			\
	       (f->G##time_gran_mantissa *		\
		pow(10., f->G##time_gran_exponent)))
	print_time(a);
	print_time(b);
	print_time(c);
	print_time(m);
}

static void dump_attr_volume_uuid(union reply *r, int size)
{
	struct fsinfo_volume_uuid *f = &r->uuid;

	printf("%02x%02x%02x%02x-%02x%02x-%02x%02x-%02x%02x"
	       "-%02x%02x%02x%02x%02x%02x\n",
	       f->uuid[ 0], f->uuid[ 1],
	       f->uuid[ 2], f->uuid[ 3],
	       f->uuid[ 4], f->uuid[ 5],
	       f->uuid[ 6], f->uuid[ 7],
	       f->uuid[ 8], f->uuid[ 9],
	       f->uuid[10], f->uuid[11],
	       f->uuid[12], f->uuid[13],
	       f->uuid[14], f->uuid[15]);
}
	
static void dump_attr_server_address(union reply *r, int size)
{
	struct fsinfo_server_address *f = &r->srv_addr;

	printf("family=%u\n", f->address.ss_family);
}
	
static void dump_attr_error_state(union reply *r, int size)
{
	struct fsinfo_error_state *f = &r->errors;

	printf("io=%u wb=%u bdev=%u\n", f->io_error, f->wb_error, f->bdev_error);
}
	
static void dump_attr_io_size(union reply *r, int size)
{
	struct fsinfo_io_size *f = &r->io_size;

	printf("bs=%u\n", f->block_size);
}

/*
 *
 */
typedef void (*dumper_t)(union reply *r, int size);

#define FSINFO_DUMPER(N) [fsinfo_attr_##N] = dump_attr_##N
static const dumper_t fsinfo_attr_dumper[fsinfo_attr__nr] = {
	FSINFO_DUMPER(statfs),
	FSINFO_DUMPER(fsinfo),
	FSINFO_DUMPER(ids),
	FSINFO_DUMPER(limits),
	FSINFO_DUMPER(supports),
	FSINFO_DUMPER(capabilities),
	FSINFO_DUMPER(timestamp_info),
	FSINFO_DUMPER(volume_uuid),
	FSINFO_DUMPER(server_address),
	FSINFO_DUMPER(error_state),
	FSINFO_DUMPER(io_size),
};

static void dump_fsinfo(enum fsinfo_attribute attr, __u8 about,
			union reply *r, int size)
{
	dumper_t dumper = fsinfo_attr_dumper[attr];
	unsigned int len;

	if (!dumper) {
		printf("<no dumper>\n");
		return;
	}

	len = (about & 0x3f) * sizeof(__u32);
	if (size < len) {
		printf("<short data %u/%u>\n", size, len);
		return;
	}

	dumper(r, size);
}

/*
 * Try one subinstance of an attribute.
 */
static int try_one(const char *file, struct fsinfo_params *params, bool raw)
{
	union reply r;
	char *p;
	int ret;
	__u8 about;

	memset(&r.buffer, 0xbd, sizeof(r.buffer));

	errno = 0;
	ret = fsinfo(AT_FDCWD, file, params, r.buffer, sizeof(r.buffer));
	if (params->request >= fsinfo_attr__nr) {
		if (ret == -1 && errno == EOPNOTSUPP)
			exit(0);
		fprintf(stderr, "Unexpected error for too-large command %u: %m\n",
			params->request);
		exit(1);
	}

	//printf("fsinfo(%s,%s,%u,%u) = %d: %m\n",
	//       file, fsinfo_attr_names[params->request],
	//       params->Nth, params->Mth, ret);

	about = fsinfo_buffer_sizes[params->request];
	if (ret == -1) {
		if (errno == ENODATA) {
			switch (about & 0xc0) {
			case 0x00:
				if (params->Nth == 0 && params->Mth == 0) {
					fprintf(stderr,
						"Unexpected ENODATA1 (%u[%u][%u])\n",
						params->request, params->Nth, params->Mth);
					exit(1);
				}
				break;
			case 0x40:
				if (params->Nth == 0 && params->Mth == 0) {
					fprintf(stderr,
						"Unexpected ENODATA2 (%u[%u][%u])\n",
						params->request, params->Nth, params->Mth);
					exit(1);
				}
				break;
			}
			return (params->Mth == 0) ? 2 : 1;
		}
		if (errno == EOPNOTSUPP) {
			if (params->Nth > 0 || params->Mth > 0) {
				fprintf(stderr,
					"Should return -ENODATA (%u[%u][%u])\n",
					params->request, params->Nth, params->Mth);
				exit(1);
			}
			//printf("\e[33m%s\e[m: <not supported>\n",
			//       fsinfo_attr_names[attr]);
			return 2;
		}
		perror(file);
		exit(1);
	}

	if (raw) {
		if (ret > 4096)
			ret = 4096;
		dump_hex((unsigned int *)&r.buffer, 0, ret);
		return 0;
	}

	switch (about & 0xc0) {
	case 0x00:
		printf("\e[33m%s\e[m: ", fsinfo_attr_names[params->request]);
		break;
	case 0x40:
		printf("\e[33m%s[%u]\e[m: ",
		       fsinfo_attr_names[params->request],
		       params->Nth);
		break;
	case 0x80:
		printf("\e[33m%s[%u][%u]\e[m: ",
		       fsinfo_attr_names[params->request],
		       params->Nth, params->Mth);
		break;
	}		

	switch (about) {
		/* Struct */
	case 0x01 ... 0x3f:
	case 0x41 ... 0x7f:
	case 0x81 ... 0xbf:
		dump_fsinfo(params->request, about, &r, ret);
		return 0;

		/* String */
	case 0x00:
	case 0x40:
	case 0x80:
		if (ret >= 4096) {
			ret = 4096;
			r.buffer[4092] = '.';
			r.buffer[4093] = '.';
			r.buffer[4094] = '.';
			r.buffer[4095] = 0;
		} else {
			r.buffer[ret] = 0;
		}
		for (p = r.buffer; *p; p++) {
			if (!isprint(*p)) {
				printf("<non-printable>\n");
				continue;
			}
		}
		printf("%s\n", r.buffer);
		return 0;

	default:
		fprintf(stderr, "Fishy about %u %02x\n", params->request, about);
		exit(1);
	}
}

/*
 *
 */
int main(int argc, char **argv)
{
	struct fsinfo_params params = {
		.at_flags = AT_SYMLINK_NOFOLLOW,
	};
	unsigned int attr;
	int raw = 0, opt, Nth, Mth;

	while ((opt = getopt(argc, argv, "alr"))) {
		switch (opt) {
		case 'a':
			params.at_flags |= AT_NO_AUTOMOUNT;
			continue;
		case 'l':
			params.at_flags &= ~AT_SYMLINK_NOFOLLOW;
			continue;
		case 'r':
			raw = 1;
			continue;
		}
		break;
	}

	argc -= optind;
	argv += optind;

	if (argc != 1) {
		printf("Format: test-fsinfo [-alr] <file>\n");
		exit(2);
	}		

	for (attr = 0; attr <= fsinfo_attr__nr; attr++) {
		Nth = 0;
		do {
			Mth = 0;
			do {
				params.request = attr;
				params.Nth = Nth;
				params.Mth = Mth;

				switch (try_one(argv[0], &params, raw)) {
				case 0:
					continue;
				case 1:
					goto done_M;
				case 2:
					goto done_N;
				}
			} while (++Mth < 100);

		done_M:
			if (Mth >= 100) {
				fprintf(stderr, "Fishy: Mth == %u\n", Mth);
				break;
			}
				
		} while (++Nth < 100);

	done_N:
		if (Nth >= 100) {
			fprintf(stderr, "Fishy: Nth == %u\n", Nth);
			break;
		}
	}

	return 0;
}
