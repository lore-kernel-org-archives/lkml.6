Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+m2+Vsg5+jBxBCwZtewObds1yZi9iR2Hkyw2AbuNwIK6gcOImZGJbjGne1nML4KCBCSP4V
ARC-Seal: i=1; a=rsa-sha256; t=1523472535; cv=none;
        d=google.com; s=arc-20160816;
        b=bzrT2XnR4mHjJeQKL5F8jaN+9MEkiRHXU2aK4ldwiz5czJQ/TrJxbTl9r71BuIVXl2
         Du+5QBXAWixIZIH8/DDeuBOF09FDiCKuJ0+4JTLyBsCchOz3BCe8+RvS6M/IMLUqLBBr
         v+ZiJMHEP1Kyind5NUVw7mnxGXuGcRYm2cuuoh3wVqBYE9jExrs7Ohmx+FPn/F3XRPpl
         bxmKISNVepOW5aE8r8VUf4msmg5qN+gg0w9yWwXdFK+N+bhGqLiZqP49/DXTMJZSVqZh
         HTdrI0KCEVOpt7iKGH8tVW46WKL8u7AbGtUApSabg4kKP9kvuuk+grCjjKkwUEaKtht4
         aLTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=lv1XkHzO12D1lQdNj4JwvAf8E59oodXRypNaTEYQnyk=;
        b=kWqBrVkEpFUpstvbDEH/Q+jU1qspvDhkcdbze+oMxJQZcwMKKuzpLpXtg/s/BelsrM
         +ub3eTen2Qlt7leVlTdBj87tl4clL5y4G8nF/9Z4Eig+m1oEY0y7GY7Uu8qpDOXTX0Dl
         8zyermjvwbfX1lSQIE7PBv7L9Wl4L/G+iIvy0cvNfM44zos/Tz5SuRq1nGrN3UTBbfNB
         ZGK9hoo+l0ZS3T3DpCfQxu5UgThNWBI040Nus3V85nUuiWy9ssbPFLeucazM25Zol0hK
         dgndxzQCiUy5ZPALdiuZNvL4/HG1l5swTg81H1kVMQxzXF0YDvMuvDH6QphaG/TvIFOE
         bRoQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Namhyung Kim <namhyung@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Andi Kleen <andi@firstfloor.org>,
	David Ahern <dsahern@gmail.com>,
	Peter Zijlstra <a.p.zijlstra@chello.nl>,
	kernel-team@lge.com,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.4 121/190] perf header: Set proper module name when build-id event found
Date: Wed, 11 Apr 2018 20:36:07 +0200
Message-Id: <20180411183558.608495202@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180411183550.114495991@linuxfoundation.org>
References: <20180411183550.114495991@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597476737917927440?=
X-GMAIL-MSGID: =?utf-8?q?1597476737917927440?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Namhyung Kim <namhyung@kernel.org>


[ Upstream commit 1deec1bd96ccd8beb04d2112a6d12fe20505c3a6 ]

When perf processes build-id event, it creates DSOs with the build-id.
But it didn't set the module short name (like '[module-name]') so when
processing a kernel mmap event of the module, it cannot found the DSO as
it only checks the short names.

That leads for perf to create a same DSO without the build-id info and
it'll lookup the system path even if the DSO is already in the build-id
cache.  After kernel was updated, perf cannot find the DSO  and cannot
show symbols in it anymore.

You can see this if you have an old data file (w/ old kernel version):

  $ perf report -i perf.data.old -v |& grep scsi_mod
  build id event received for /lib/modules/3.19.2-1-ARCH/kernel/drivers/scsi/scsi_mod.ko.gz : cafe1ce6ca13a98a5d9ed3425cde249e57a27fc1
  Failed to open /lib/modules/3.19.2-1-ARCH/kernel/drivers/scsi/scsi_mod.ko.gz, continuing without symbols
  ...

The second message didn't show the build-id.  With this patch:

  $ perf report -i perf.data.old -v |& grep scsi_mod
  build id event received for /lib/modules/3.19.2-1-ARCH/kernel/drivers/scsi/scsi_mod.ko.gz: cafe1ce6ca13a98a5d9ed3425cde249e57a27fc1
  /lib/modules/3.19.2-1-ARCH/kernel/drivers/scsi/scsi_mod.ko.gz with build id cafe1ce6ca13a98a5d9ed3425cde249e57a27fc1 not found, continuing without symbols
  ...

Now it shows the build-id but still cannot load the symbol table.  This
is a different problem which will be fixed in the next patch.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Cc: Andi Kleen <andi@firstfloor.org>
Cc: David Ahern <dsahern@gmail.com>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: kernel-team@lge.com
Link: http://lkml.kernel.org/r/20170531120105.21731-1-namhyung@kernel.org
[ Fix the build on older compilers (debian <= 8, fedora <= 21, etc) wrt kmod_path var init ]
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 tools/perf/util/header.c |   12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -1258,8 +1258,16 @@ static int __event_process_build_id(stru
 
 		dso__set_build_id(dso, &bev->build_id);
 
-		if (!is_kernel_module(filename, cpumode))
-			dso->kernel = dso_type;
+		if (dso_type != DSO_TYPE_USER) {
+			struct kmod_path m = { .name = NULL, };
+
+			if (!kmod_path__parse_name(&m, filename) && m.kmod)
+				dso__set_short_name(dso, strdup(m.name), true);
+			else
+				dso->kernel = dso_type;
+
+			free(m.name);
+		}
 
 		build_id__sprintf(dso->build_id, sizeof(dso->build_id),
 				  sbuild_id);
