Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752655AbeA3TBb (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 14:01:31 -0500
Received: from mx0a-00191d01.pphosted.com ([67.231.149.140]:54733 "EHLO
        mx0a-00191d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751749AbeA3TB3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 14:01:29 -0500
From: "Brown, Nicholas" <nb930b@intl.att.com>
To: "joe@perches.com" <joe@perches.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "apw@canonical.com" <apw@canonical.com>
Subject: [PATCH] checkpatch: warn if changed lines exceeds a maximum size
Thread-Topic: [PATCH] checkpatch: warn if changed lines exceeds a maximum
 size
Thread-Index: AQHTmeMGAPsYZkfslkm5Wnly+K55WQ==
Date: Tue, 30 Jan 2018 15:57:27 +0000
Message-ID: <1517327844.3063.19.camel@intl.att.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.156.48.128]
Content-Type: text/plain; charset="utf-8"
Content-ID: <A8AC8B3DC7E24B49A5B61EE4A923DEFF@intl.att.com>
MIME-Version: 1.0
X-RSA-Inspected: yes
X-RSA-Classifications: public
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-01-30_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_policy_notspam policy=outbound_policy score=0
 priorityscore=1501 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0
 spamscore=0 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=966 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1711220000 definitions=main-1801300199
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w0UJ1ZYn001256

Changed lines is the total of inserted and deleted lines.
By default there is no limit, --max-changed-lines may be used to set a
value. Some users may wish to encourage that patches are split into
smaller parts using this.
See Documentation/process/submitting-patches.rst#split-changes

Signed-off-by: Nicholas Brown <nick.brown@att.com>
---
 scripts/checkpatch.pl | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 31031f10fe56..1217d782b6bb 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -49,6 +49,7 @@ my @ignore = ();
 my $help = 0;
 my $configuration_file = ".checkpatch.conf";
 my $max_line_length = 80;
+my $max_changed_lines; # undef = no max
 my $ignore_perl_version = 0;
 my $minimum_perl_version = 5.10.0;
 my $min_conf_desc_length = 4;
@@ -209,6 +210,7 @@ GetOptions(
        'show-types!'   => \$show_types,
        'list-types!'   => \$list_types,
        'max-line-length=i' => \$max_line_length,
+       'max-changed-lines=i' => \$max_changed_lines,
        'min-conf-desc-length=i' => \$min_conf_desc_length,
        'root=s'        => \$root,
        'summary!'      => \$summary,
@@ -2165,6 +2167,8 @@ sub process {
        my $filename = shift;
 
        my $linenr=0;
+       my $inserted_lines_total=0;
+       my $deleted_lines_total=0;
        my $prevline="";
        my $prevrawline="";
        my $stashline="";
@@ -2233,6 +2237,14 @@ sub process {
 
                push(@fixed, $rawline) if ($fix);
 
+               if ($rawline=~/^\+/) {
+                 $inserted_lines_total++
+               }
+
+               if ($rawline=~/^-/) {
+                 $deleted_lines_total++
+               }
+
                if ($rawline=~/^\+\+\+\s+(\S+)/) {
                        $setup_docs = 0;
                        if ($1 =~ m@Documentation/admin-guide/kernel-parameters.rst$@) {
@@ -2306,6 +2318,11 @@ sub process {
 
        $prefix = '';
 
+       if (defined $max_changed_lines &&
+           ($inserted_lines_total+$deleted_lines_total > $max_changed_lines)) {
+         WARN("MAX_CHANGED_LINES", "please split the change into smaller parts\n");
+       }
+
        $realcnt = 0;
        $linenr = 0;
        $fixlinenr = -1;
-- 
2.14.1
