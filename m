Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932403AbeCEBy3 (ORCPT <rfc822;w@1wt.eu>);
        Sun, 4 Mar 2018 20:54:29 -0500
Received: from cock.li ([185.100.85.212]:54034 "EHLO cock.li"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752017AbeCEBy0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Mar 2018 20:54:26 -0500
From: Tom Lebreux <tomlebreux@cock.li>
Subject: Fixing checkpatch.pl false positive for IIO_DEV_ATTR_CH_OFF
To: linux-kernel@vger.kernel.org
Cc: Andy Whitcroft <apw@canonical.com>, Joe Perches <joe@perches.com>,
        Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Message-ID: <110e9ac8-cd2e-0b09-7896-dcead45ce874@cock.li>
Date: Sun, 4 Mar 2018 20:54:19 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

currently, checkpatch.pl gives false positive NON_OCTAL_PERMISSIONS
errors for IIO_DEV_ATTR_CH_OFF (beginning of output removed):

$ ./scripts/checkpatch.pl -f drivers/staging/iio/meter/ade7759.c                                                                                                     
...
ERROR: Use 4 digit octal (0777) not decimal permissions
#331: FILE: drivers/staging/iio/meter/ade7759.c:331:
+static IIO_DEV_ATTR_CH_OFF(1, 0644,
+               ade7759_read_8bit,
+               ade7759_write_8bit,
+               ADE7759_CH1OS);
...

checkpatch.pl matches IIO_DEV_ATTR_[A-Z_]+ with the first argument, but
the mode for IIO_DEV_ATTR_CH_OFF is the second argument.

A quick grep in drivers/ shows that IIO_DEV_ATTR_CH_OFF is used only four 
times (drivers/staging/iio/meter/ade775{3,9}.c). This means one way of solving
this problem would be to change IIO_DEV_ATTR_CH_OFF to have the mode as the 
first argument.

Another way would be adding an exclude field to @mode_permission_funcs in
checkpatch.pl. I added an example patch at the end of this email. The exclude
would be also a regex. This would allow us to solve the issue as shown below:

@@ -554,7 +554,8 @@ our @mode_permission_funcs = (
["debugfs_create_(?:file|u8|u16|u32|u64|x8|x16|x32|x64|size_t|atomic_t|bool|blob|regset32|u32_array)", 2],
        ["proc_create(?:_data|)", 2],
        ["(?:CLASS|DEVICE|SENSOR|SENSOR_DEVICE|IIO_DEVICE)_ATTR", 2],
-       ["IIO_DEV_ATTR_[A-Z_]+", 1],
+       ["IIO_DEV_ATTR_CH_OFF", 2],
+       ["IIO_DEV_ATTR_[A-Z_]+", 1, "IIO_DEV_ATTR_CH_OFF"],

I don't think listing all the different IIO_DEV_ATTR_* in mode_permission_funcs is
a good solution because there are many:

$ grep "define IIO_DEV_ATTR_" -R drivers/ | wc -l                                                                                                                    
125

Example exclusion patch:

---
 scripts/checkpatch.pl | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 3d4040322ae1..4f77fa7b6aa1 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -6379,6 +6379,7 @@ sub process {
 			foreach my $entry (@mode_permission_funcs) {
 				my $func = $entry->[0];
 				my $arg_pos = $entry->[1];
+				my $exclude_func = $entry->[2];
 
 				my $lc = $stat =~ tr@\n@@;
 				$lc = $lc + $linenr;
@@ -6392,8 +6393,14 @@ sub process {
 					$arg_pos--;
 					$skip_args = "(?:\\s*$FuncArg\\s*,\\s*){$arg_pos,$arg_pos}";
 				}
+
 				my $test = "\\b$func\\s*\\(${skip_args}($FuncArg(?:\\|\\s*$FuncArg)*)\\s*[,\\)]";
 				if ($stat =~ /$test/) {
+					if ($exclude_func) {
+						my $exclude_test = "\\b$exclude_func\\s*\\(${skip_args}($FuncArg(?:\\|\\s*$FuncArg)*)\\s*[,\\)]";
+						next if ($stat =~ /$exclude_test/);
+					}
+
 					my $val = $1;
 					$val = $6 if ($skip_args ne "");
 					if (!($func =~ /^(?:module_param|proc_create)/ && $val eq "0") &&
-- 
2.16.2
