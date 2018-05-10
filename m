Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752522AbeEJTqK (ORCPT <rfc822;w@1wt.eu>);
        Thu, 10 May 2018 15:46:10 -0400
Received: from mailout.easymail.ca ([64.68.200.34]:51354 "EHLO
        mailout.easymail.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750876AbeEJTqF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 May 2018 15:46:05 -0400
Subject: Re: [PATCH v2] selftests/cgroup: memory controller self-tests
To: Roman Gushchin <guro@fb.com>, Tejun Heo <tj@kernel.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@suse.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>, kernel-team@fb.com,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shuah Khan <shuah@kernel.org>
References: <20180510163701.28936-1-guro@fb.com>
From: Shuah Khan <shuah@kernel.org>
Message-ID: <a9adb726-9ba4-b29d-cae1-55bd832fe51d@kernel.org>
Date: Thu, 10 May 2018 13:45:49 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180510163701.28936-1-guro@fb.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/10/2018 10:37 AM, Roman Gushchin wrote:
> Cgroups are used for controlling the physical resource distribution
> (memory, CPU, io, etc) and often are used as basic building blocks
> for large distributed computing systems. Even small differences
> in the actual behavior may lead to significant incidents.
> 
> The codebase is under the active development, which will unlikely
> stop at any time soon. Also it's scattered over different
> kernel subsystems, which makes regressions more probable.
> 
> Given that, the lack of any tests is crying.
> 
> This patch implements some basic tests for the memory controller,
> as well as a minimal required framework.
> It doesn't pretend for a very good coverage, but pretends
> to be a starting point.
> 
> Hopefully, any following significant changes will
> include corresponding tests.
> 
> Tests for CPU and io controllers, as well as cgroup core
> are next in the todo list.
> 
> Signed-off-by: Roman Gushchin <guro@fb.com>
> Cc: Tejun Heo <tj@kernel.org>
> Cc: Shuah Khan <shuah@kernel.org>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Mike Rapoport <rppt@linux.vnet.ibm.com>
> Cc: kernel-team@fb.com
> Cc: linux-kselftest@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> ---
>  tools/testing/selftests/Makefile                 |   1 +
>  tools/testing/selftests/cgroup/Makefile          |  10 +
>  tools/testing/selftests/cgroup/cgroup_util.c     | 317 ++++++++++
>  tools/testing/selftests/cgroup/cgroup_util.h     |  40 ++
>  tools/testing/selftests/cgroup/test_memcontrol.c | 741 +++++++++++++++++++++++
>  5 files changed, 1109 insertions(+)
>  create mode 100644 tools/testing/selftests/cgroup/Makefile
>  create mode 100644 tools/testing/selftests/cgroup/cgroup_util.c
>  create mode 100644 tools/testing/selftests/cgroup/cgroup_util.h
>  create mode 100644 tools/testing/selftests/cgroup/test_memcontrol.c
> 
> diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
> index 32aafa92074c..24d0331d6c11 100644
> --- a/tools/testing/selftests/Makefile
> +++ b/tools/testing/selftests/Makefile
> @@ -3,6 +3,7 @@ TARGETS = android
>  TARGETS += bpf
>  TARGETS += breakpoints
>  TARGETS += capabilities
> +TARGETS += cgroup
>  TARGETS += cpufreq
>  TARGETS += cpu-hotplug
>  TARGETS += efivarfs
> diff --git a/tools/testing/selftests/cgroup/Makefile b/tools/testing/selftests/cgroup/Makefile
> new file mode 100644
> index 000000000000..f7a31392eb2f
> --- /dev/null
> +++ b/tools/testing/selftests/cgroup/Makefile
> @@ -0,0 +1,10 @@
> +# SPDX-License-Identifier: GPL-2.0
> +CFLAGS += -Wall
> +
> +all:
> +
> +TEST_GEN_PROGS = test_memcontrol
> +
> +include ../lib.mk
> +
> +$(OUTPUT)/test_memcontrol: cgroup_util.c
> diff --git a/tools/testing/selftests/cgroup/cgroup_util.c b/tools/testing/selftests/cgroup/cgroup_util.c
> new file mode 100644
> index 000000000000..a938b6c8b55a
> --- /dev/null
> +++ b/tools/testing/selftests/cgroup/cgroup_util.c
> @@ -0,0 +1,317 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +
> +#define _GNU_SOURCE
> +
> +#include <errno.h>
> +#include <fcntl.h>
> +#include <linux/limits.h>
> +#include <signal.h>
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <string.h>
> +#include <sys/stat.h>
> +#include <sys/types.h>
> +#include <sys/wait.h>
> +#include <unistd.h>
> +
> +#include "cgroup_util.h"
> +
> +static ssize_t read_text(const char *path, char *buf, size_t max_len)
> +{
> +	ssize_t len;
> +	int fd;
> +
> +	fd = open(path, O_RDONLY);
> +	if (fd < 0)
> +		return fd;
> +
> +	len = read(fd, buf, max_len - 1);
> +	if (len < 0)
> +		goto out;
> +
> +	buf[len] = 0;
> +out:
> +	close(fd);
> +	return len;
> +}
> +
> +static ssize_t write_text(const char *path, char *buf, size_t len)
> +{
> +	int fd;
> +
> +	fd = open(path, O_WRONLY | O_APPEND);
> +	if (fd < 0)
> +		return fd;
> +
> +	len = write(fd, buf, len);
> +	if (len < 0) {
> +		close(fd);
> +		return len;
> +	}
> +
> +	close(fd);
> +
> +	return len;
> +}
> +
> +char *cg_name(const char *root, const char *name)
> +{
> +	size_t len = strlen(root) + strlen(name) + 2;
> +	char *ret = malloc(len);
> +
> +	if (name)
> +		snprintf(ret, len, "%s/%s", root, name);
> +
> +	return ret;
> +}
> +
> +char *cg_name_indexed(const char *root, const char *name, int index)
> +{
> +	size_t len = strlen(root) + strlen(name) + 10;
> +	char *ret = malloc(len);
> +
> +	if (name)
> +		snprintf(ret, len, "%s/%s_%d", root, name, index);
> +
> +	return ret;
> +}
> +
> +int cg_read(const char *cgroup, const char *control, char *buf, size_t len)
> +{
> +	char path[PATH_MAX];
> +
> +	snprintf(path, sizeof(path), "%s/%s", cgroup, control);
> +
> +	if (read_text(path, buf, len) >= 0)
> +		return 0;
> +
> +	return -1;
> +}
> +
> +int cg_read_strcmp(const char *cgroup, const char *control,
> +		   const char *expected)
> +{
> +	size_t size = strlen(expected) + 1;
> +	char *buf;
> +
> +	buf = malloc(size);
> +	if (!buf)
> +		return -1;
> +
> +	if (cg_read(cgroup, control, buf, size))
> +		return -1;
> +
> +	return strcmp(expected, buf);
> +}
> +
> +int cg_read_strstr(const char *cgroup, const char *control, const char *needle)
> +{
> +	char buf[PAGE_SIZE];
> +
> +	if (cg_read(cgroup, control, buf, sizeof(buf)))
> +		return -1;
> +
> +	return strstr(buf, needle) ? 0 : -1;
> +}
> +
> +long cg_read_long(const char *cgroup, const char *control)
> +{
> +	char buf[128];
> +
> +	if (cg_read(cgroup, control, buf, sizeof(buf)))
> +		return -1;
> +
> +	return atol(buf);
> +}
> +
> +long cg_read_key_long(const char *cgroup, const char *control, const char *key)
> +{
> +	char buf[PAGE_SIZE];
> +	char *ptr;
> +
> +	if (cg_read(cgroup, control, buf, sizeof(buf)))
> +		return -1;
> +
> +	ptr = strstr(buf, key);
> +	if (!ptr)
> +		return -1;
> +
> +	return atol(ptr + strlen(key));
> +}
> +
> +int cg_write(const char *cgroup, const char *control, char *buf)
> +{
> +	char path[PATH_MAX];
> +	size_t len = strlen(buf);
> +
> +	snprintf(path, sizeof(path), "%s/%s", cgroup, control);
> +
> +	if (write_text(path, buf, len) == len)
> +		return 0;
> +
> +	return -1;
> +}
> +
> +int cg_find_unified_root(char *root, size_t len)
> +{
> +	char buf[10 * PAGE_SIZE];
> +	char *fs, *mount, *type;
> +	const char delim[] = "\n\t ";
> +
> +	if (read_text("/proc/self/mounts", buf, sizeof(buf)) <= 0)
> +		return -1;
> +
> +	/*
> +	 * Example:
> +	 * cgroup /sys/fs/cgroup cgroup2 rw,seclabel,noexec,relatime 0 0
> +	 */
> +	for (fs = strtok(buf, delim); fs; fs = strtok(NULL, delim)) {
> +		mount = strtok(NULL, delim);
> +		type = strtok(NULL, delim);
> +		strtok(NULL, delim);
> +		strtok(NULL, delim);
> +		strtok(NULL, delim);
> +
> +		if (strcmp(fs, "cgroup") == 0 &&
> +		    strcmp(type, "cgroup2") == 0) {
> +			strncpy(root, mount, len);
> +			return 0;
> +		}
> +	}
> +
> +	return -1;
> +}
> +
> +int cg_create(const char *cgroup)
> +{
> +	return mkdir(cgroup, 0644);
> +}
> +
> +static int cg_killall(const char *cgroup)
> +{
> +	char buf[PAGE_SIZE];
> +	char *ptr = buf;
> +
> +	if (cg_read(cgroup, "cgroup.procs", buf, sizeof(buf)))
> +		return -1;
> +
> +	while (ptr < buf + sizeof(buf)) {
> +		int pid = strtol(ptr, &ptr, 10);
> +
> +		if (pid == 0)
> +			break;
> +		if (*ptr)
> +			ptr++;
> +		else
> +			break;
> +		if (kill(pid, SIGKILL))
> +			return -1;
> +	}
> +
> +	return 0;
> +}
> +
> +int cg_destroy(const char *cgroup)
> +{
> +	int ret;
> +
> +retry:
> +	ret = rmdir(cgroup);
> +	if (ret && errno == EBUSY) {
> +		ret = cg_killall(cgroup);
> +		if (ret)
> +			return ret;
> +		usleep(100);
> +		goto retry;
> +	}
> +
> +	if (ret && errno == ENOENT)
> +		ret = 0;
> +
> +	return ret;
> +}
> +
> +int cg_run(const char *cgroup,
> +	   int (*fn)(const char *cgroup, void *arg),
> +	   void *arg)
> +{
> +	int pid, retcode;
> +
> +	pid = fork();
> +	if (pid < 0) {
> +		return pid;
> +	} else if (pid == 0) {
> +		char buf[64];
> +
> +		snprintf(buf, sizeof(buf), "%d", getpid());
> +		if (cg_write(cgroup, "cgroup.procs", buf))
> +			exit(EXIT_FAILURE);
> +		exit(fn(cgroup, arg));
> +	} else {
> +		waitpid(pid, &retcode, 0);
> +		if (WIFEXITED(retcode))
> +			return WEXITSTATUS(retcode);
> +		else
> +			return -1;
> +	}
> +}
> +
> +int cg_run_nowait(const char *cgroup,
> +		  int (*fn)(const char *cgroup, void *arg),
> +		  void *arg)
> +{
> +	int pid;
> +
> +	pid = fork();
> +	if (pid == 0) {
> +		char buf[64];
> +
> +		snprintf(buf, sizeof(buf), "%d", getpid());
> +		if (cg_write(cgroup, "cgroup.procs", buf))
> +			exit(EXIT_FAILURE);
> +		exit(fn(cgroup, arg));
> +	}
> +
> +	return pid;
> +}
> +
> +int get_temp_fd(void)
> +{
> +	return open(".", O_TMPFILE | O_RDWR | O_EXCL);
> +}
> +
> +int alloc_pagecache(int fd, size_t size)
> +{
> +	char buf[PAGE_SIZE];
> +	struct stat st;
> +	int i;
> +
> +	if (fstat(fd, &st))
> +		goto cleanup;
> +
> +	size += st.st_size;
> +
> +	if (ftruncate(fd, size))
> +		goto cleanup;
> +
> +	for (i = 0; i < size; i += sizeof(buf))
> +		read(fd, buf, sizeof(buf));
> +
> +	return 0;
> +
> +cleanup:
> +	return -1;
> +}
> +
> +int alloc_anon(const char *cgroup, void *arg)
> +{
> +	size_t size = (unsigned long)arg;
> +	char *buf, *ptr;
> +
> +	buf = malloc(size);
> +	for (ptr = buf; ptr < buf + size; ptr += PAGE_SIZE)
> +		*ptr = 0;
> +
> +	free(buf);
> +	return 0;
> +}
> diff --git a/tools/testing/selftests/cgroup/cgroup_util.h b/tools/testing/selftests/cgroup/cgroup_util.h
> new file mode 100644
> index 000000000000..000de075d3d8
> --- /dev/null
> +++ b/tools/testing/selftests/cgroup/cgroup_util.h
> @@ -0,0 +1,40 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#include <stdlib.h>
> +
> +#define PAGE_SIZE 4096
> +
> +#define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]))
> +
> +#define MB(x) (x << 20)
> +
> +/*
> + * Checks if two given values differ by less than err% of their sum.
> + */
> +static inline int values_close(long a, long b, int err)
> +{
> +	return abs(a - b) <= (a + b) / 100 * err;
> +}
> +
> +extern int cg_find_unified_root(char *root, size_t len);
> +extern char *cg_name(const char *root, const char *name);
> +extern char *cg_name_indexed(const char *root, const char *name, int index);
> +extern int cg_create(const char *cgroup);
> +extern int cg_destroy(const char *cgroup);
> +extern int cg_read(const char *cgroup, const char *control,
> +		   char *buf, size_t len);
> +extern int cg_read_strcmp(const char *cgroup, const char *control,
> +			  const char *expected);
> +extern int cg_read_strstr(const char *cgroup, const char *control,
> +			  const char *needle);
> +extern long cg_read_long(const char *cgroup, const char *control);
> +long cg_read_key_long(const char *cgroup, const char *control, const char *key);
> +extern int cg_write(const char *cgroup, const char *control, char *buf);
> +extern int cg_run(const char *cgroup,
> +		  int (*fn)(const char *cgroup, void *arg),
> +		  void *arg);
> +extern int cg_run_nowait(const char *cgroup,
> +			 int (*fn)(const char *cgroup, void *arg),
> +			 void *arg);
> +extern int get_temp_fd(void);
> +extern int alloc_pagecache(int fd, size_t size);
> +extern int alloc_anon(const char *cgroup, void *arg);
> diff --git a/tools/testing/selftests/cgroup/test_memcontrol.c b/tools/testing/selftests/cgroup/test_memcontrol.c
> new file mode 100644
> index 000000000000..b6bbc4c1adc3
> --- /dev/null
> +++ b/tools/testing/selftests/cgroup/test_memcontrol.c
> @@ -0,0 +1,741 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#define _GNU_SOURCE
> +
> +#include <linux/limits.h>
> +#include <fcntl.h>
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <string.h>
> +#include <sys/stat.h>
> +#include <sys/types.h>
> +#include <unistd.h>
> +
> +#include "../kselftest.h"
> +#include "cgroup_util.h"
> +
> +/*
> + * Can't use KSFT_ values,
> + * because there is no difference between SKIP and PASS values.
> + */
> +enum test_result {
> +	TEST_SKIP,
> +	TEST_FAIL,
> +	TEST_PASS,
> +};
> +

Please check linux-kselftest next - You will see thet SKIP handling
patches in there.

Please clean this up before they get into 4.18-rc1

thanks,
-- Shuah
