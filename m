Return-Path: <SRS0=Se0q=LB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 320B8C43615
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Aug 2018 20:47:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCEA121748
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Aug 2018 20:47:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="D//RHAK8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BCEA121748
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rasmusvillemoes.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726560AbeHRX4d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Aug 2018 19:56:33 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:46873 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726488AbeHRX4d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Aug 2018 19:56:33 -0400
Received: by mail-ed1-f65.google.com with SMTP id o8-v6so6322252edt.13
        for <linux-kernel@vger.kernel.org>; Sat, 18 Aug 2018 13:47:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to;
        bh=HGgKq4MjM7BUYa1MqSUhzGEevoXYWMSrL2lGm2JrN7g=;
        b=D//RHAK8/oH7Ev0wk7ZlrDF0Lq5qQOQVlYhscb7DqF1CkrRv/zKZGvjZOHGNcohjqC
         FbZv1Ll5bd/G3SaMIrrxSsPKv1Od/qcHwrhYKaIhAkAPqwwixAdQ/jPrB6BvXxPMA3WL
         7WPA+4cG73REUAI0CKg0vxZGrlfseVqjiL9tY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to;
        bh=HGgKq4MjM7BUYa1MqSUhzGEevoXYWMSrL2lGm2JrN7g=;
        b=DtrlAkvuWU0Np9WMp4nCnMJYgnVroFKe+BAxs0LJF+Fj7iUKgcg451Da8+/RE/xwuT
         Box+fH+nq2FuIN44VrKxk50RrHanbXEHzghkJU+cUdbLoD2u2GhO6ZqFpQ1wOtBBAxEb
         nfJ0reTzEoal02qMnk5KTO0nCSpdnlSIadUbz53xisj0sbstFplc0n8TrmE4JmvBAMEh
         NOuXuDmb+eSqQ1rdXrYtBLJbahDPXOwZpW4nUAEPi5XfFsPlm4vq0rd+52JpC7mGlCGu
         GiVgi/kd6vZBY6Pig2UkWq5omEaNmjWxNUFR+4jAnm5fIbRTg+cufX+Lxv5ABC6SmX1g
         +C6w==
X-Gm-Message-State: AOUpUlG8Mhv76fD+9AZTlxPQHraQdMOJEB5neRqFpM/zDHTalYrteZXi
        qikXZIDN7lYw3tQat8SQFf7rMQ==
X-Google-Smtp-Source: AA+uWPykNxI6Str/AyU3xJdGcUWKERwv4EJmOVxeMqtpV2/SCqiS6fot2DzxcuDTG3rNKVbhRqq77g==
X-Received: by 2002:a50:8f84:: with SMTP id y4-v6mr49320940edy.71.1534625253460;
        Sat, 18 Aug 2018 13:47:33 -0700 (PDT)
Received: from prevas-ravi.waoo.dk (dhcp-5-186-114-212.cgn.ip.fibianet.dk. [5.186.114.212])
        by smtp.gmail.com with ESMTPSA id z56-v6sm3038119edz.54.2018.08.18.13.47.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 18 Aug 2018 13:47:32 -0700 (PDT)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org,
        linux-kbuild@vger.kernel.org
Subject: [RFC PATCH] scripts: add header bloat measuring script
Date:   Sat, 18 Aug 2018 22:47:23 +0200
Message-Id: <20180818204723.11060-1-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.16.4
In-Reply-To: 0180226075931.5vn4vdbfcsje2z56@gmail.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With a little cooperation from fixdep, we can rather easily quantify the
header bloat phenomenon.

While computing CONFIG_ dependencies, fixdep opens all the headers used
by a given translation unit anyway, so it's rather cheap to have it
record the number and total size of those in the generated .o.cmd file.

Those lines can then be post-processed and summarized by the new
header-bloat-stat.pl script. For example, backporting this to v4.17 and
v4.18 releases shows that for a defconfig x86_64 kernel, the median
"bloat factor" (total size of translation unit)/(size of .c file)
increased from 237.7 to 239.8, and the average total translation unit
size grew by 2.5% while the average .c file only increased by
0.4%. While these numbers by themselves are not particularly alarming,
when accumulated over several releases, builds do get noticably slower -
back at v3.0, the median bloat factor was 177.8.

Having infrastrucure like this makes it easier to measure the effect
should anyone attempt something similar to the sched.h cleanup, or just
go over a subsystem trimming unused #includes from .c files (if the
script is passed one or more directories it only processes those).

On a positive note, maybe 4.19 will be a rare exception; as of
1f7a4c73a739, the median bloat factor is down to 236.0, the average .c
file has increased by 0.4% but the average total translation unit is
nevertheless 1.2% smaller, compared to v4.18.

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
For some statistics, that also include build times, for releases v3.0
through v4.15, see https://wildmoose.dk/header-bloat/ . I'm not sure
that page will remain forever, so not including the url in the commit
log.

I can certainly understand if people feel this is of too little
utility to hook into fixdep like this. It's certainly possible to do
the same statistics with external tools that just parse the .o.cmd
files themselves.

 scripts/basic/fixdep.c       | 18 +++++++--
 scripts/header-bloat-stat.pl | 95 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 109 insertions(+), 4 deletions(-)
 create mode 100755 scripts/header-bloat-stat.pl

diff --git a/scripts/basic/fixdep.c b/scripts/basic/fixdep.c
index 850966f3d602..f1dec85cf9d9 100644
--- a/scripts/basic/fixdep.c
+++ b/scripts/basic/fixdep.c
@@ -248,7 +248,7 @@ static void parse_config_file(const char *p)
 	}
 }
 
-static void *read_file(const char *filename)
+static void *read_file(const char *filename, unsigned *size)
 {
 	struct stat st;
 	int fd;
@@ -276,6 +276,8 @@ static void *read_file(const char *filename)
 	}
 	buf[st.st_size] = '\0';
 	close(fd);
+	if (size)
+		*size += st.st_size;
 
 	return buf;
 }
@@ -300,6 +302,8 @@ static void parse_dep_file(char *m, const char *target, int insert_extra_deps)
 	int saw_any_target = 0;
 	int is_first_dep = 0;
 	void *buf;
+	unsigned nheaders = 0, c_size = 0, h_size = 0;
+	unsigned *sizevar;
 
 	while (1) {
 		/* Skip any "white space" */
@@ -321,6 +325,8 @@ static void parse_dep_file(char *m, const char *target, int insert_extra_deps)
 			/* The /next/ file is the first dependency */
 			is_first_dep = 1;
 		} else if (!is_ignored_file(m, p - m)) {
+			sizevar = NULL;
+
 			*p = '\0';
 
 			/*
@@ -343,13 +349,16 @@ static void parse_dep_file(char *m, const char *target, int insert_extra_deps)
 					printf("source_%s := %s\n\n",
 					       target, m);
 					printf("deps_%s := \\\n", target);
+					sizevar = &c_size;
 				}
 				is_first_dep = 0;
 			} else {
 				printf("  %s \\\n", m);
+				sizevar = &h_size;
+				nheaders++;
 			}
 
-			buf = read_file(m);
+			buf = read_file(m, sizevar);
 			parse_config_file(buf);
 			free(buf);
 		}
@@ -373,7 +382,8 @@ static void parse_dep_file(char *m, const char *target, int insert_extra_deps)
 		do_extra_deps();
 
 	printf("\n%s: $(deps_%s)\n\n", target, target);
-	printf("$(deps_%s):\n", target);
+	printf("$(deps_%s):\n\n", target);
+	printf("# header-stats: %u %u %u\n", nheaders, c_size, h_size);
 }
 
 int main(int argc, char *argv[])
@@ -394,7 +404,7 @@ int main(int argc, char *argv[])
 
 	printf("cmd_%s := %s\n\n", target, cmdline);
 
-	buf = read_file(depfile);
+	buf = read_file(depfile, NULL);
 	parse_dep_file(buf, target, insert_extra_deps);
 	free(buf);
 
diff --git a/scripts/header-bloat-stat.pl b/scripts/header-bloat-stat.pl
new file mode 100755
index 000000000000..528021907df1
--- /dev/null
+++ b/scripts/header-bloat-stat.pl
@@ -0,0 +1,95 @@
+#!/usr/bin/perl
+
+use strict;
+use warnings;
+
+use Getopt::Long;
+use File::Find;
+use Statistics::Descriptive;
+
+sub help {
+    printf "%s [-c] [-m] [-n <name>] [<dirs>]\n", $0;
+    printf "  -c  output a single line with data in columns\n";
+    printf "  -m  include min/max statistics\n";
+    printf "  -n  optional name (e.g. git revision) to use as first datum\n";
+    exit(0);
+}
+
+my $name;
+my $minmax = 0;
+my $column = 0;
+
+GetOptions("c|column" => \$column,
+	   "m|minmax" => \$minmax,
+	   "n|name=s" => \$name,
+	   "h|help"   => \&help)
+    or die "Bad option";
+
+my @stats =
+    (
+     ['mean',   sub {$_[0]->mean()}],
+     ['min',    sub {$_[0]->min()}],
+     ['q25',    sub {$_[0]->quantile(1)}],
+     ['median', sub {$_[0]->quantile(2)}],
+     ['q75',    sub {$_[0]->quantile(3)}],
+     ['max',    sub {$_[0]->max()}],
+    );
+
+my @scalars = ('hcount', 'csize', 'tsize', 'ratio');
+my %data;
+my @out;
+
+find({wanted => \&process_cmd_file, no_chdir => 1}, @ARGV ? @ARGV : '.');
+
+add_output('name', $name) if $name;
+add_output('#TUs', $data{ntu});
+for my $s (@scalars) {
+    my $vals = Statistics::Descriptive::Full->new();
+    $vals->add_data(@{$data{$s}});
+    $vals->sort_data();
+    for my $stat (@stats) {
+	next if $s eq 'ratio' && $stat->[0] eq 'mean';
+	next if $stat->[0] =~ m/^(min|max)$/ && !$minmax;
+	my $val = $stat->[1]->($vals);
+	add_output($s . "_" . $stat->[0], $val);
+    }
+}
+
+if ($column) {
+    print join("\t", map {$_->[1]} @out), "\n";
+} else {
+    printf "%s\t%s\n", @$_ for @out;
+}
+
+sub add_output {
+    push @out, [@_];
+}
+
+sub process_cmd_file {
+    # Remove leading ./ components
+    s|^(\./)*||;
+    # Stuff that includes userspace/host headers is not interesting.
+    if (m/^(scripts|tools)/) {
+	$File::Find::prune = 1;
+	return;
+    }
+    return unless m/\.o\.cmd$/;
+
+    open(my $fh, '<', $_)
+	or die "failed to open $_: $!";
+    while (<$fh>) {
+	chomp;
+	if (m/^source_/) {
+	    # Only process stuff built from .S or .c
+	    return unless m/\.[Sc]$/;
+	}
+	if (m/^# header-stats: ([0-9]+) ([0-9]+) ([0-9]+)/) {
+	    push @{$data{hcount}}, $1;
+	    push @{$data{csize}}, $2;
+	    push @{$data{tsize}}, $2 + $3;
+	    push @{$data{ratio}}, $2 ? ($2 + $3)/$2 : 1.0;
+	    $data{ntu}++;
+	}
+    }
+    close($fh);
+}
-- 
2.16.4

